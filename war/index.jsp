<!DOCTYPE html>
<html>
<head>
	<title>Wordsearch Builder</title>
	<link rel="stylesheet" type="text/css" href="base.css" />
</head>
<body>
<h1>Wordsearch Builder</h1>
<a href="about.jsp">About</a>

<h2>Words</h2>
<form action="build.jsp" method="post">
Name: <input type="text" size="25" name="name" value="Wordsearch"><br />
<textarea name="words" rows="10">
Kitchen
Lounge
Study
Ballroom
Conservatory
Billiard Room
Library
Hall
Dining Room
</textarea>
	<br />
	<input type="number" name="height" min="3" max="50" value="15" />
	<input type="number" name="width" min="3" max="50" value="15" />
	<input type="checkbox" name="simple" value="yes">Simple [<span class="tooltip" title="In simple mode, words are only placed Left-to-Right or Top-to-Bottom">?</span>]</span>
	<input type="submit" value="Build!" />
</form>

<%@include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
