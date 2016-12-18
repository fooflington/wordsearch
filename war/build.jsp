<html>
<head>
	<title>Wordsearch builder</title>
	<style>
	table, th, td {
		border: 1px solid black;
		border-collapse: collapse;
		padding: 2px 4px;
	}
	</style>
</head>
<%@ page import="uk.org.mafoo.wordsearch.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="error.jsp" %>
<%

	int height = Integer.parseInt(request.getParameter("height"));
	int width  = Integer.parseInt(request.getParameter("width"));

	if (request.getParameter("words").length() > 2048) { throw new Exception("Input too large"); }
	if (height > 100 || width > 100) { throw new Exception("Dimentions too large"); }

	List<String> words = new ArrayList<String>();
	for ( String line : request.getParameter("words").split("\r\n")) {
		words.add(line.trim());
	}
  	
  	char[][] grid = GridFactory.makeGrid(words, height, width);
%>
<body>
<h1>Wordsearch builder</h1>
<h2>Words</h2>

<div style="float: right; padding: 15px;">
	<ul>
	<% for (String word : words) { %>
	   <li><%= word.trim() %></li>
	<% } %>
	</ul>
</div>

<h2>Grid</h2>
<table style="font-family: monospace; font-size: 16;">
<% for(char[] row : grid) { %>
	<tr>
		<% for(char c : row) { %>
		<td><%= c %></td>
		<% } %>
	</tr>
<% } %>
</table>

</body>
</html>
