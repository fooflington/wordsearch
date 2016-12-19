<html>
<head><title>Wordsearch builder</title></head>
<body>
<h1>Wordsearch builder</h1>
<a href="about.html">About</a>

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
	<input type="checkbox" name="simple" value="yes">Simple?
	<input type="submit" value="Build!" />
</form>


</body>
</html>
