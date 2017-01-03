<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="uk.org.mafoo.wordsearch.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page errorPage="api-error.jsp" %>
<%

        int height = Integer.parseInt(request.getParameter("height"));
        int width  = Integer.parseInt(request.getParameter("width"));
        boolean simple = request.getParameter("simple") != null;
        String name = StringEscapeUtils.escapeHtml(request.getParameter("name"));

        if (request.getParameter("words").length() > 2048) { throw new Exception("Input too large"); }
        if (height > 100 || width > 100) { throw new Exception("Dimentions too large"); }

        List<String> words = new ArrayList<String>();
        for ( String line : request.getParameter("words").split(",")) {
                words.add(line.trim());
        }
        Collections.sort(words);

        char[][] grid = GridFactory.makeGrid(words, height, width, simple);

	List<List<String>> grid_ar = new ArrayList<List<String>>(); 
	for ( char[] row : grid ) {
		ArrayList<String> row_ar = new ArrayList<String>();
		for ( char cell : row ) {
			row_ar.add("" + cell);
		}
		grid_ar.add(row_ar);
	}

	JSONObject resp = new JSONObject();
	
	resp.put("grid", grid_ar);
	resp.put("words", words);
	resp.put("height", height);
	resp.put("width", width);
	resp.put("isSimple", simple);

%>
<%= resp %>
