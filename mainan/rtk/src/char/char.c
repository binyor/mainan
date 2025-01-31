#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>

#include "core.h"
#include "socket.h"
#include "timer.h"
#include "char.h"
#include "logif.h"
#include "mapif.h"
#include "db.h"
#include "char_db.h"

int char_port = 2005;

struct mmo_charstatus* char_dat;
struct map_fifo_data map_fifo[MAX_MAP_SERVER];

int map_fifo_n = 0;
int map_fifo_max = 0;
struct Sql* sql_handle;
int char_fd;
int login_fd;

struct point start_pos;

char char_id[32];
char char_pw[32];
//Sql ID/PW
char sql_id[32] = "";
char sql_pw[32] = "";
char sql_db[32] = "";
char sql_ip[32] = "";
int sql_port;

char login_id[32];
char login_pw[32];
char login_ip_s[16];
in_addr_t login_ip;
int login_port;

int mapfifo_from_mapid(int map) {
	int i, j;
	for (i = 0; i < map_fifo_max; i++) {
		if (map_fifo[i].fd > 0) {
			for (j = 0; j < map_fifo[i].map_n; j++) {
				if (map_fifo[i].map[j] == map) {
					return i;
				}
			}
		}
	}
	return -1;
}

/*==========================================
 * Configuration File Read
 *------------------------------------------
 */
int config_read(const char* cfg_file) {
	char line[1024], r1[1024], r2[1024];
	int line_num = 0;
	FILE* fp;

	fp = fopen(cfg_file, "r");
	if (fp == NULL) {
		printf("[char_server] error=config reason=file %s not found\n", cfg_file);
		exit(1);
	}

	while (fgets(line, sizeof(line), fp)) {
		line_num++;
		if (line[0] == '/' && line[1] == '/')
			continue;

		if (sscanf(line, "%[^:]: %[^\r\n]", r1, r2) == 2) {
			if (strcasecmp(r1, "char_port") == 0) {
				char_port = (int)strtol(r2, NULL, 10);
			}
			else if (strcasecmp(r1, "char_id") == 0) {
				strncpy(char_id, r2, 32);
				char_id[31] = '\0';
			}
			else if (strcasecmp(r1, "char_pw") == 0) {
				strncpy(char_pw, r2, 32);
				char_pw[31] = '\0';
			}
			else if (strcasecmp(r1, "login_ip") == 0) {
				strncpy(login_ip_s, r2, 16);
				login_ip_s[15] = '\0';
				login_ip = inet_addr(login_ip_s);
			}
			else if (strcasecmp(r1, "login_port") == 0) {
				login_port = (int)strtol(r2, NULL, 10);
			}
			else if (strcasecmp(r1, "login_id") == 0) {
				strncpy(login_id, r2, 32);
				login_id[31] = '\0';
			}
			else if (strcasecmp(r1, "login_pw") == 0) {
				strncpy(login_pw, r2, 32);
				login_pw[31] = '\0';
				//Save
			}
			else if (strcasecmp(r1, "sql_ip") == 0) {
				strcpy(sql_ip, r2);
			}
			else if (strcasecmp(r1, "sql_port") == 0) {
				sql_port = (int)strtol(r2, NULL, 10);
			}
			else if (strcasecmp(r1, "sql_id") == 0) {
				strcpy(sql_id, r2);
			}
			else if (strcasecmp(r1, "sql_pw") == 0) {
				strcpy(sql_pw, r2);
			}
			else if (strcasecmp(r1, "sql_db") == 0) {
				strcpy(sql_db, r2);
			}
			else if (strcasecmp(r1, "char_log") == 0) {
				set_logfile(r2);
			}
			else if (strcasecmp(r1, "dump_log") == 0) {
				set_dmpfile(r2);
			}
			else if (strcasecmp(r1, "start_point") == 0) {
				sscanf(r2, "%hu,%hu,%hu", &start_pos.m, &start_pos.x, &start_pos.y);
			}
		}
	}
	fclose(fp);
	printf("[char_server] status=pending message=config file %s processed\n", cfg_file);

	return 0;
}

void do_term(void) {
	char_db_term();
	session_eof(login_fd);
	printf("[char_server] status=terminated\n");
}

void help_screen() {
	printf("HELP LIST\n");
	printf("---------\n");
	printf(" --conf [FILENAME]  : set config file\n");
	printf(" --inter [FILENAME] : set inter file\n");
	exit(0);
}

int do_init(int argc, char** argv) {
	int i;
	char* CONF_FILE = "../conf/char.conf";
	char* INTER_FILE = "../conf/inter.conf";

	srand(gettick());
	set_logfile("log/char.log");
	set_dmpfile("log/char_dump.log");

	for (i = 1; i < argc; i++) {
		if (strcmp(argv[i], "--help") == 0 || strcmp(argv[i], "--h") == 0 || strcmp(argv[i], "--?") == 0 || strcmp(argv[i], "/?") == 0)
			help_screen();
		else if (strcmp(argv[i], "--conf") == 0)
			CONF_FILE = argv[i + 1];
		else if (strcmp(argv[i], "--inter") == 0)
			INTER_FILE = argv[i + 1];
	}

	config_read(CONF_FILE);
	config_read(INTER_FILE);
	set_termfunc(do_term);

	char_db_init();

	set_defaultparse(mapif_parse_auth);
	char_fd = make_listen_port(char_port);

	timer_insert(1000, 1000 * 10, check_connect_login, login_ip, login_port);
    char_dat = calloc(1, sizeof(struct mmo_charstatus));

    printf("[char_server] status=ready ip=0.0.0.0 port=%d\n", char_port);

	return 0;
}
