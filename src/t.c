char** t(int a, int b);
char** t(int a, int b) {
	char t[a][b];
	int i, j;
	for (i=0; i<a; i++) {
		for (j=0; j<b; j++) {
			t[i][j] = 'x';
		}
	}

	return t;
}

int main() {
	char **thing = t(5, 8);
	exit(1);
}
