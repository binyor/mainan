
%.o: %.c
	@echo -e " Compile... $<"
	@$(CC) $(CFLAGS) -c -o $@ $<

all: char-server

char-server: char.o logif.o mapif.o char_db.o $(COMMON_OBJ)
	@echo -e " Linking... $<"
	@$(CC) -o $(BIN)/$@ char.o logif.o mapif.o char_db.o $(COMMON_OBJ) $(CLIBS)

char.o: char.c
logif.o: logif.c
mapif.o: mapif.c
char_db.o: char_db.c

clean:
	@rm -f *.o ../../char-server
