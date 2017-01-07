#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <ctype.h>

#include "rnd.h"
#include "dir.h"
#include "grid.h"

enum exitcodes {
	EXIT_WORDTOOLONG,
};

bounds *get_bounds(int height, int width, enum direction direction, int length)
{
	if (length > height || length > width) {
		return NULL;
	}

	length--;

	bounds *b = (bounds *) malloc(sizeof(bounds));

	b->min_x = 0;
	b->max_x = width-1;
	b->min_y = 0;
	b->max_y = height-1;
	if (direction == DIRECTION_N ||
	    direction == DIRECTION_NE || direction == DIRECTION_NW) {
		b->min_y = length;
	}

	if (direction == DIRECTION_W ||
	    direction == DIRECTION_NW || direction == DIRECTION_SW) {
		b->min_x = length;
	}

	if (direction == DIRECTION_E ||
	    direction == DIRECTION_NE || direction == DIRECTION_SE) {
		b->max_x = width - length;
	}

	if (direction == DIRECTION_S ||
	    direction == DIRECTION_SW || direction == DIRECTION_SE) {
		b->max_y = height - length;
	}

	return b;
}

int move_x(int x, enum direction d) {
	if(
			d == DIRECTION_E  ||
			d == DIRECTION_NE ||
			d == DIRECTION_SE
	  ) {
		x++;
	} else if (
			d == DIRECTION_W  ||
			d == DIRECTION_NW ||
			d == DIRECTION_SW
		  ) {
		x--;
	}

	return x;
}

int move_y(int y, enum direction d) {
	if(
			d == DIRECTION_N  ||
			d == DIRECTION_NE ||
			d == DIRECTION_NW
	  ) {
		y--;
	} else if (
			d == DIRECTION_S  ||
			d == DIRECTION_SE ||
			d == DIRECTION_SW
		  ) {
		y++;
	}

	return y;
}

char **make_grid(char **words, int height, int width, int simple, int count)
{
	char **grid = init_grid(NULL, height, width);
	for(int i=0; i<count; i++) {
		int tries = 0;
		int placed = 0;
		while(tries++ < WORDSEARCH_MAXTRIES && placed == 0) {
			if(place_word(words[i], grid, height, width, simple)) {
				placed = 1;
			}
		}
	}
	return grid;
}

int place_word(char *word, char **grid, int height, int width, int simple)
{
	int dir = get_direction(simple);
	bounds *b;

	if (b = get_bounds(height, width, dir, strlen(word))) {
		/* word will probably fit... */
		int x, y;
		x = random_number(b->min_x, b->max_x);
		y = random_number(b->min_y, b->max_y);

		char** tempgrid = init_grid(grid, height, width);
		/* Now we have two copies of the grid, try to place the word... */
		int i;
		for(i=0; i<strlen(word); i++) {
			if(!isalpha(word[i])) continue;
			if(tempgrid[y][x] != '_') {
				if(tempgrid[y][x] != word[i]) {
					/* Failed to place word */
					free_grid(tempgrid, height);
					return 0;
				} else {
					/* word crossed ok! */
				}
			} else {
				tempgrid[y][x] = word[i];
			}

			x = move_x(x, dir);
			y = move_y(y, dir);
		}

		free_grid(grid, height);
		free(b);
		grid = tempgrid;
		return 1;
	} else {
		/* word can't fit */
		printf("[ERR] Word too long to place in this grid: %s\n", word);
		exit(EXIT_WORDTOOLONG);
	}

}

/* Clones or creates an empty grid - pass NULL in as old to get an empty grid */
char **init_grid(char** old, int height, int width)
{
	int row, cell;
	char **new = malloc(height * sizeof(char*));

	for (row=0; row < height; row++) {
		new[row] = malloc(width * sizeof(char));
		for (cell=0; cell < width; cell++) {
			if(old) {
				new[row][cell] = old[row][cell];
			} else {
				new[row][cell] = '_';
			}
		}
	}	

	return new;
}

void free_grid(char** grid, int height) {
	for (int i=0; i<height; i++) {
		free(grid[i]);
	}
	free(grid);
}

void print_grid(char** grid, int height);
void print_grid(char** grid, int height) {
	for(int i=0; i<height; i++) {
		if(grid[i] == NULL) {
			printf("row error\n");
		} else {
			printf("%s\n", grid[i]);
		}
	}
}

#ifdef DEBUG_GRID_MAIN
#include <stdio.h>
int main()
{
	char *words[4] = {
		"test",
		"word",
		"longer",
		"verylong"
	};
	char **grid = make_grid(words, 10, 10, 0, 4);
	print_grid(grid, 4);
}
#endif
