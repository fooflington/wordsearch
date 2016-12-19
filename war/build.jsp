<html>
<head>
	<title>Wordsearch builder</title>
	<style>
	body { font-family: sans-serif; }
	table, th, td {
		border: 1px solid black;
		border-collapse: collapse;
		padding: 2px 4px;
	}

	#grid {
		font-family: monospace; font-size: 16;
	}

	#wrapper {
		width: 80%;
		margin: 0 auto;
	}
	#wordsearch {
		float: left;
	}

	#words {
		float: right;
		width: 200px;
	}

	@media only print {
		.noprint {
			display: none;
		}
	}
	</style>
</head>
<%@ page import="uk.org.mafoo.wordsearch.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%

	int height = Integer.parseInt(request.getParameter("height"));
	int width  = Integer.parseInt(request.getParameter("width"));
	boolean simple = request.getParameter("simple") != null;
	String name = StringEscapeUtils.escapeHtml(request.getParameter("name"));

	if (request.getParameter("words").length() > 2048) { throw new Exception("Input too large"); }
	if (height > 100 || width > 100) { throw new Exception("Dimentions too large"); }

	List<String> words = new ArrayList<String>();
	for ( String line : request.getParameter("words").split("\r\n")) {
		words.add(line.trim());
	}
  	Collections.sort(words);

  	char[][] grid = GridFactory.makeGrid(words, height, width, simple);

  	String csv = "";
%>
<body>
<h1><%= name %></h1>
<a id='csvdownload' class="noprint">Download CSV</a>
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
			<td><%= c %></td>
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
<div>
</body>
</html>
