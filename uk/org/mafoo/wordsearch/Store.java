package uk.org.mafoo.wordsearch;

import java.sql.*;


class Store {

	Connection conn = null;

	protected Store(String dbfile) {
		try {
			Class.forName("org.sqlite.JDBC");
	        conn = DriverManager.getConnection("jdbc:sqlite:" + dbfile);
	    } catch ( Exception e ) {
	        System.err.println( e.getClass().getName() + ": " + e.getMessage() );
	        System.exit(1);
		}
	}

	protected storeInstance()

}