package uk.org.mafoo.wordsearch;

class Bounds {
	int min_y;
	int max_y;
	int min_x;
	int max_x;

	protected Bounds(int min_y, int max_y, int min_x, int max_x) {
		this.min_y = min_y;
		this.max_y = max_y;
		this.min_x = min_x;
		this.max_x = max_x;
	}

	public String toString() {
		return "[" + min_x + " < x < " + max_x + " & " + min_y + " < y < " + max_y +"]";
	}
}