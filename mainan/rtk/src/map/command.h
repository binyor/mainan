#ifndef _COMMAND_H_
#define _COMMAND_H_

#include <lua.h>

#include "mmo.h"

int is_command(USER*, const char*, int);
int at_command(USER*, const char*, int);
int command_reload(USER* sd, char* line, lua_State* state);
#endif
