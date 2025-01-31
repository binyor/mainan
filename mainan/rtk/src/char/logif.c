#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>

#include "core.h"
#include "socket.h"
#include "char.h"
#include "logif.h"
#include "crypt.h"
#include "char_db.h"
#include "malloc.h"

static const int packet_len_table[] = { 3, 20, 43, 40, 52,0, 0 };

int check_connect_login(int ip, int port) {
    // Convert the ip address to a string for logging
    // 40 character string is the max length of ipv6 address
    char ip_string[40];
    inet_ntop(AF_INET, &ip, ip_string, sizeof(ip_string));

    if (login_fd <= 0 || session[login_fd] == NULL) {
		printf("[char_server] action=gossip target=login_server ip=%s port=%d message=connecting\n", ip_string, port);
		login_fd = make_connection(ip, port);
		session[login_fd]->func_parse = logif_parse;
		realloc_rfifo(login_fd, FIFOSIZE_SERVER, FIFOSIZE_SERVER);
		WFIFOHEAD(login_fd, 69);
		WFIFOB(login_fd, 0) = 0xAA;
		WFIFOW(login_fd, 1) = SWAP16(66);
		WFIFOB(login_fd, 3) = 0xFF;
		WFIFOB(login_fd, 4) = RAND_INC;
		memcpy(WFIFOP(login_fd, 5), login_id, 32);
		memcpy(WFIFOP(login_fd, 37), login_pw, 32);
		set_packet_indexes(WFIFOP(login_fd, 0));
        tk_crypt(WFIFOP(login_fd, 0));
		WFIFOSET(login_fd, 69 + 3);
	}
	return 0;
}
int logif_parse_accept(int fd) {
	if (RFIFOB(fd, 2)) {
		printf("CFG_ERR: Username or password to connect Login Server is invalid!\n");
		add_log("CFG_ERR: Username or password to connect Login Server is invalid!\n");
	}
	else {
        printf("[char_server] action=gossip target=login_server message=connected\n");
    }
	return 0;
}
int logif_parse_usedname(int fd) {
	int res;
	char name[16];
	memset(name, 0, 16);
	memcpy(name, RFIFOP(fd, 4), 16);
	res = char_db_isnameused(name);
	WFIFOHEAD(fd, 5);
	WFIFOW(fd, 0) = 0x2001;
	WFIFOW(fd, 2) = RFIFOW(fd, 2);
	WFIFOB(fd, 4) = res;
	WFIFOSET(fd, 5);
	return 0;
}

int logif_parse_newchar(int fd) {
	int res;
	res = char_db_newchar((char *)RFIFOP(fd, 4), (char *)RFIFOP(fd, 20), RFIFOB(fd, 39), RFIFOB(fd, 37) % 2, RFIFOB(fd, 38), RFIFOB(fd, 36), RFIFOB(fd, 40), RFIFOB(fd, 42), RFIFOB(fd, 41));
	WFIFOHEAD(fd, 5);
	WFIFOW(fd, 0) = 0x2002;
	WFIFOW(fd, 2) = RFIFOW(fd, 2);
	WFIFOB(fd, 4) = res;
	WFIFOSET(fd, 5);
	return 0;
}
int logif_parse_login(int fd) {
	int res;
	unsigned int id = 0;

	res = char_db_mapfifofromlogin((char *)RFIFOP(fd, 4), (char *)RFIFOP(fd, 20), &id);

	//printf("Res: %i\n",res);

	WFIFOHEAD(fd, 27);
	if (res < 0) {
		//printf("Shit1\n");
		WFIFOW(fd, 0) = 0x2003;
		WFIFOW(fd, 2) = RFIFOW(fd, 2);
		WFIFOB(fd, 4) = abs(res);
		WFIFOSET(fd, 27);
		return 0;
	}
	if (logindata_add(id, res, (char *)RFIFOP(fd, 4))) {
		//printf("Shit2\n");
		//character is online, force disconnected
		WFIFOW(fd, 0) = 0x2003;
		WFIFOW(fd, 2) = RFIFOW(fd, 2);
		WFIFOB(fd, 4) = 0x06;
		WFIFOSET(fd, 27);

		WFIFOHEAD(map_fifo[res].fd, 6);
		WFIFOW(map_fifo[res].fd, 0) = 0x3804;
		WFIFOL(map_fifo[res].fd, 2) = id;
		WFIFOSET(map_fifo[res].fd, 6);
		return 0;
	}
	WFIFOHEAD(map_fifo[res].fd, 38);

	WFIFOW(map_fifo[res].fd, 0) = 0x3802;
	WFIFOW(map_fifo[res].fd, 2) = RFIFOW(fd, 2);
	WFIFOL(map_fifo[res].fd, 4) = id;
	memset(WFIFOP(map_fifo[res].fd, 8), 0, 16);
	memcpy(WFIFOP(map_fifo[res].fd, 8), RFIFOP(fd, 4), 16);
	WFIFOL(map_fifo[res].fd, 34) = RFIFOL(fd, 36);
	WFIFOSET(map_fifo[res].fd, 38);

	return 0;
}
int logif_parse_setpass(int fd) {
	int res;
	res = char_db_setpass((char *)RFIFOP(fd, 4), (char *)RFIFOP(fd, 20), (char *)RFIFOP(fd, 36));
	WFIFOHEAD(fd, 5);
	WFIFOW(fd, 0) = 0x2004;
	WFIFOW(fd, 2) = RFIFOW(fd, 2);
	WFIFOB(fd, 4) = abs(res);
	WFIFOSET(fd, 5);
	return 0;
}
int logif_parse(int fd) {
	int cmd, packet_len;

	if (fd != login_fd) return 0;

	if (session[fd]->eof) {
		printf("[char_server] action=gossip target=login_server message=timeout\n");
		login_fd = 0;

		session_eof(fd);

		return 0;
	}

	if (RFIFOB(fd, 0) == 0xAA) {
		int len = SWAP16(RFIFOW(fd, 1)) + 3;
		if (len <= RFIFOREST(fd))
			RFIFOSKIP(fd, len);
		return 0;
	}

	cmd = RFIFOW(fd, 0);

	if (cmd < 0x1000 || cmd >= 0x1000 + (sizeof(packet_len_table) / sizeof(packet_len_table[0])) ||
		packet_len_table[cmd - 0x1000] == 0) {
		return 0;
	}

	packet_len = packet_len_table[cmd - 0x1000];

	if (packet_len == -1) {
		if (RFIFOREST(fd) < 6)
			return 2;
		packet_len = RFIFOL(fd, 2);
	}
	if ((int)RFIFOREST(fd) < packet_len) {
		return 2;
	}

	switch (cmd) {
	case 0x1000: logif_parse_accept(fd); break;
	case 0x1001: logif_parse_usedname(fd); break;
	case 0x1002: logif_parse_newchar(fd); break;
	case 0x1003: logif_parse_login(fd); break;
	case 0x1004: logif_parse_setpass(fd); break;
    default: break;
	}

	RFIFOSKIP(fd, packet_len);
	return 0;
}
