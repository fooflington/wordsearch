<!DOCTYPE html>
<html>
<head>
	<title>Wordsearch builder</title>
	<link rel="stylesheet" type="text/css" href="base.css" />
	<link href="https://fonts.googleapis.com/css2?family=Fira+Mono:wght@400;500&family=Roboto:wght@500&display=swap" rel="stylesheet">
</head>
<%@ page import="uk.org.mafoo.wordsearch.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page errorPage="error.jsp" %>
<%

	int height = Integer.parseInt(request.getParameter("height"));
	int width  = Integer.parseInt(request.getParameter("width"));
	boolean simple = request.getParameter("simple") != null;
	String name = StringEscapeUtils.escapeHtml(request.getParameter("name"));

	if (request.getParameter("words").length() > 2048) { throw new Exception("Input too large"); }
	if (height > 100 || width > 100) { throw new Exception("Dimensions too large"); }

	List<String> words = new ArrayList<String>();
	for ( String line : request.getParameter("words").split("\r\n")) {
		words.add(line.trim().toLowerCase());
	}
  	Collections.sort(words);

  	char[][] grid = GridFactory.makeGrid(words, height, width, simple);

  	String csv = "";
%>
<body>
<h1><%= name %></h1>
<div class="noprint">
	[ <a href="index.jsp">Start again</a> | <a id='csvdownload'>Download CSV</a> ]
</div>
<script>
    var csv = '<%= csv %>';
    var csvdownload = document.getElementById('csvdownload');
    csvdownload.href='data:text/csv;base64,' + btoa(csv);
</script>
</div>

<div id="wrapper">
<div id="wordsearch">
	<h2>Grid</h2>
	<table id="grid">
	<% for(char[] row : grid) { %>
		<tr>
			<% for(char c : row) {
				csv += "" + c + ',';
			%>
			<td class="cell"><%= c %></td>
			<% 	} %>
		</tr>
	<%
		csv += "\\n";
		}
	%>
	</table>
</div> <!-- end wordsearch -->

<div id="words">
	<h2>Words</h2>
		<ul>
		<% for (String word : words) { %>
		   <li><%= word.trim() %></li>
		<% } %>
		</ul>
</div> <!-- end words -->
</div> <!-- end wrapper -->
<br />
<br />
<%@include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
