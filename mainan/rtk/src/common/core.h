#ifndef	_CORE_H_
#define	_CORE_H_

#define META_MAX 20

extern int metamax;
extern int nex_version;
extern int nex_deep;

int main(int, char**);
const char* get_svn_revision(void);
unsigned int getTicks(void);
void crash_log(char*, ...);
void set_dmpfile(char*);
void add_dmp(int, int);
void set_logfile(char*);
void set_termfunc(void (*termfunc)(void));
static void sig_proc(int);
static void display_title(void);
int set_default_input(int(*func)(char*));
int default_parse_input(char*);
int do_init(int, char**);

extern char meta_file[META_MAX][256];

#endif	// _CORE_H_
