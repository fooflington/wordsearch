#include <stdlib.h>

#include "rnd.h"
#include "dir.h"
#include "grid.h"

bounds *get_bounds(int height, int width, enum direction direction, int length) {
	if(length > height || length > width) {
		return NULL;
	}

	bounds *b = (bounds *) malloc (sizeof(bounds));

	b->min_x = 0;
	b->max_x = width;
	b->min_y = 0;
	b->max_y = height;
	if(
		direction == DIRECTION_N  ||
		direction == DIRECTION_NE ||
		direction == DIRECTION_NW
	) {
		b->min_y = length;
	}

	if(
		direction == DIRECTION_W  ||
		direction == DIRECTION_NW ||
		direction == DIRECTION_SW
	) {
		b->min_x = length;
	}

	if(
		direction == DIRECTION_E  ||
		direction == DIRECTION_NE ||
		direction == DIRECTION_SE
	) {
		b->max_x = width - length;
	}

	if(
		direction == DIRECTION_S  ||
		direction == DIRECTION_SW ||
		direction == DIRECTION_SE
	) {
		b->max_y = height - length;
	}

	return b;
}

char** makegrid (char** words, int height, int width, int simple) {
 return NULL;
}

#ifdef DEBUG_GRID_MAIN
#include <stdio.h>
int main() {
	int dir = get_direction(0); 
	bounds* bounds = get_bounds(10, 10, dir, 8);
	printf("DIR=%d =>  %d < height < %d  &  %d < width < %d\n", 
		dir, 
		bounds->min_y, bounds->max_y,
		bounds->min_x, bounds->max_x
		);
	free(bounds);
}
#endif