#pragma once

struct login_session_data {
	unsigned int id;
	char name[16];
	char pass[16];
	char face, country, totem, sex, hair, face_color, hair_color;
};

int clif_message(int, char, char*);
int clif_sendurl(int, int, char*);
int send_metafile(int fd, char* file);
int send_meta(int fd);
int send_metalist(int fd);

int clif_accept(int);
int clif_parse(int);
