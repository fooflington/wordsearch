#ifndef WORDSEARCH_GRID
#define WORDSEARCH_GRID

#define WORDSEARCH_MAXTRIES 500

char** makegrid (char** words, int height, int width, int simple);

typedef struct bounds {
    int min_y;
    int max_y;
    int min_x;
    int max_x;
} bounds;

/* returns NULL if cannot fit word; caller needs to free() the response */
bounds* get_bounds(int height, int width, enum direction direction, int length);

#endif