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
<%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>

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

	Connection conn = DriverManager.getConnection(
		"jdbc:sqlite:" + getServletContext().getRealPath("/WEB-INF/files/database.sqlite"));
	PreparedStatement stmt = conn.prepareStatement(
		"INSERT INTO grids (remotehost, input, size_x, size_y, simple) VALUES (?, ?, ?, ?, ?)",
		Statement.RETURN_GENERATED_KEYS);
	// PreparedStatement getlastid = conn.prepareStatement("select last_insert_rowid();");
	PreparedStatement stmt2 = conn.prepareStatement("UPDATE grids SET result=? WHERE id=?");

	stmt.setString(1, request.getRemoteHost());
	stmt.setString(2, words.toString());
	stmt.setInt(3, height);
	stmt.setInt(4, width);
	stmt.setBoolean(5, simple);
	stmt.executeUpdate();
	ResultSet record_id_rs = stmt.getGeneratedKeys();
	int record_id = -1;
	if(record_id_rs.next()){
		record_id = record_id_rs.getInt(1);
	}

	// Actually generate the grid
	char[][] grid = GridFactory.makeGrid(words, height, width, simple);

	StringBuilder _csv = new StringBuilder();
	for (char[] cs : grid) {
		for(char c : cs) {
			_csv.append(c);
			_csv.append(",");
		}
		_csv.append("\r\n");
	}

	String csv = _csv.toString();

	stmt2.setString(1, csv);
	stmt2.setInt(2, record_id);
	stmt2.executeUpdate();
	conn.close();
%>
<body>
<h1><%= name %></h1>
<div class="noprint">
	[ <a href="index.jsp">Start again</a> | <a id='csvdownload' href="data:text/csv;base64,<%= Base64.getEncoder().encodeToString(csv.getBytes()) %>">Download CSV</a> ]
</div>

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
