package uk.org.mafoo.wordsearch;

import java.io.*;
import java.util.*;

public class GridFactory {

	static Random rnd = new Random();
	static final int MAX_TRIES = 5000;

	/* https://www.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html */
	static DistributedRandomNumberGenerator drng = new DistributedRandomNumberGenerator();
	static {
		drng.addNumber(0, 0.0812d); // A
		drng.addNumber(1, 0.0149d); // B
		drng.addNumber(2, 0.0271d); // C
		drng.addNumber(3, 0.0432d); // D
		drng.addNumber(4, 0.1202d); // E
		drng.addNumber(5, 0.0230d); // F
		drng.addNumber(6, 0.0203d); // G
		drng.addNumber(7, 0.0592d); // H
		drng.addNumber(8, 0.0731d); // I
		drng.addNumber(9, 0.0010d); // J
		drng.addNumber(10, 0.0069d); // K
		drng.addNumber(11, 0.0398d); // L
		drng.addNumber(12, 0.0261d); // M
		drng.addNumber(13, 0.0695d); // N
		drng.addNumber(14, 0.0768d); // O
		drng.addNumber(15, 0.0182d); // P
		drng.addNumber(16, 0.0011d); // Q
		drng.addNumber(17, 0.0602d); // R
		drng.addNumber(18, 0.0628d); // S
		drng.addNumber(19, 0.0910d); // T
		drng.addNumber(20, 0.0288d); // U
		drng.addNumber(21, 0.0111d); // V
		drng.addNumber(22, 0.0209d); // W
		drng.addNumber(23, 0.0017d); // X
		drng.addNumber(24, 0.0211d); // Y
		drng.addNumber(25, 0.0007d); // Z
	}

	private static char[] chars = new char[] {
		'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
	};

	private static char getRandomChar() {
		return chars[drng.getDistributedRandomNumber()];
	}

	public static void main(String[] args) throws IOException {
		// Test invocation
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		String s;
		List<String> words = new ArrayList<String>();

		while ((s = in.readLine()) != null && s.length() != 0) {
			words.add(s);
		}
		char[][] g = makeGrid(words, Integer.parseInt(args[0]), Integer.parseInt(args[1]), false, false);
		dump2d(g);
	}

	private static Direction[] directions = new Direction[] { Direction.N, Direction.NE, Direction.E, Direction.SE, Direction.S, Direction.SW, Direction.W, Direction.NW };
	private static Direction getDirection(boolean simple) {
		if(simple) {
			return rnd.nextBoolean() ? Direction.E : Direction.S;
		} else {
			return directions[rnd.nextInt(directions.length-1)];
		}
	}

	private static Bounds getBounds(int height, int width, Direction direction, int length) {
		// height_min
		if(length > height || length > width) {
			throw new RuntimeException("Word too long, cannot continue!");
		}

		Bounds b = new Bounds(0, height, 0, width);
		length--; // arrays, duh

		if(
			direction == Direction.N  ||
			direction == Direction.NE ||
			direction == Direction.NW
			) {
			b.min_y = length;
		}

		if(
			direction == Direction.W  ||
			direction == Direction.NW ||
			direction == Direction.SW
			) {
			b.min_x = length;
		}

		if(
			direction == Direction.E  ||
			direction == Direction.NE ||
			direction == Direction.SE
			) {
			b.max_x = width - length;
		}

		if(
			direction == Direction.S  ||
			direction == Direction.SW ||
			direction == Direction.SE
			) {
			b.max_y = height - length;
		}


		assert b.max_x > b.min_x;
		assert b.max_y > b.min_y;
		assert b.min_x < b.max_x;
		assert b.min_y < b.max_y;
		return b;
	}

	private static int move_y(int y, Direction d) {
		if(
			d == Direction.N  ||
			d == Direction.NE ||
			d == Direction.NW
			) {
			y--;
		} else if (
			d == Direction.S  ||
			d == Direction.SE ||
			d == Direction.SW
			) {
			y++;
		}

		return y;
	}

	private static int move_x(int x, Direction d) {
		if(
			d == Direction.E  ||
			d == Direction.NE ||
			d == Direction.SE
			) {
			x++;
		} else if (
			d == Direction.W  ||
			d == Direction.NW ||
			d == Direction.SW
			) {
			x--;
		}

		return x;
	}

	public static char[][] makeGrid(List<String> words, int height, int width) {
		return makeGrid(words, height, width, false, true);
	}

	public static char[][] makeGrid(List<String> words, int height, int width, boolean simple) {
		return makeGrid(words, height, width, simple, true);
	}

	public static char[][] makeGrid(List<String> words, int height, int width, boolean simple, boolean fill) {
		char[][] grid = new char[height][width];

		// Place words at random?
		for (String word : words) {
			int tries = 0;
			while(true) {
				try {
					grid = placeWord(word, grid, simple);
					break;
				} catch (CouldNotPlaceWordException e) {
					if(tries > MAX_TRIES) {
						throw new RuntimeException(e);
					}
					tries++;
					// System.out.println("[" + word + "] Crossed over... retrying");
				} finally {
					// Nothing
				}
			}
		}

		// Fill rest of grid
		if(fill) {
			for (int y=0; y<height; y++) {
				for (int x=0; x<width; x++) {
					if (grid[y][x] == Character.UNASSIGNED)
						// grid[y][x] = '_';
						grid[y][x] = getRandomChar();
				}
			}
		}

		return grid;
	}

	private static char[][] placeWord(String word, char[][] grid, boolean simple) throws CouldNotPlaceWordException {
		Direction direction = getDirection(simple);
		Bounds b = getBounds(grid.length, grid[0].length, direction, word.length());
		// System.out.println("[" + word + "] bounds: " + b);

		int x = rnd.nextInt(b.max_x - b.min_x) + b.min_x;
		int y = rnd.nextInt(b.max_y - b.min_y) + b.min_y;

		// System.out.println("[" + word + "] Placing @ " + x + "," + y + " going " + direction);
		char[][] tempgrid = clone2d(grid);
		for( char c : word.toUpperCase().toCharArray() ) {
			if(!Character.isLetter(c)) continue;
			if(grid[y][x] != Character.UNASSIGNED) {
				if (grid[y][x] != c) {
					throw new CouldNotPlaceWordException();
				} else {
					// System.out.println("**** SUCCESSFUL CROSSED WORD ****");
				}
			}
			tempgrid[y][x] = c;
			x = move_x(x, direction);
			y = move_y(y, direction);

		}
		return tempgrid;
	}

	private static char[][] clone2d(char[][] source) {
		// dump2d(source);
		char[][] clone = source.clone();

		for(int i=0; i<source.length; i++) {
			clone[i] = source[i].clone();
		}

		// dump2d(clone);
		return clone;
	}

	private static void dump2d(char[][] g) {
		for(char[] row : g) {
			for(char c : row) {
				// System.out.print("|");
				System.out.print(c != Character.UNASSIGNED ? c : " ");
			}
			System.out.println("");
		}
	}
}
