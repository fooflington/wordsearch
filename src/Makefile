CC=gcc
CFLAGS=-DDEBUG_GRID_MAIN -std=c99 -g
DEPS=dir.o rnd.o grid.o

wordsearch: $(DEPS)
	$(CC) -o wordsearch $(DEPS) $(CFLAGS)

%.o: %.c 
	$(CC) -c -o $@ $< $(CFLAGS)

clean:
	rm $(DEPS)
