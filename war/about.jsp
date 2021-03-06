<!DOCTYPE html>
<html>
<head>
	<title>Wordsearch Builder: About</title>
	<link rel="stylesheet" type="text/css" href="base.css" />
	<link href="https://fonts.googleapis.com/css2?family=Fira+Mono:wght@400;500&family=Roboto:wght@500&display=swap" rel="stylesheet">
</head>

<body>
	<h1><a href="index.jsp">Wordsearch Builder</a>: About</h1>
	<p>Wordsearch Builder takes a list of words and places them on a grid in any direction allowing the to cross-over where possible then fills in the remaining empty spaces with semi-random letters.</p>
	<p>Please feel free to use the generated wordsearches for whatever you want including in school classrooms or for personal use.</p>

	<ul>
		<li>Code available on <a href="https://github.com/fooflington/wordsearch">GitHub</a>.</li>
		<li>For more information please contact <a href="mailto:wordsearch@mafoo.org.uk">wordsearch@mafoo.org.uk</a>.</li>
	</ul>
	<h2>Basic algorithm</h2>
	<ol>
		<li>Foreach word
			<ol>
				<li>Pick a direction at random</li>
				<li>Compute possible start points based on word length, direction and grid size</li>
				<li>Begin placing word. If an occupied cell is encountered which contains a different character than would go in for this word, then abort and start this word again.</li>
			</ol>
		</li>
		<li>When all words are placed, infill the remaining cells with random characters weighted by <a href="https://www.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html">standard English letter frequencies</a></li>
	</ol>
	The abort-and-retry word placement to try 500 times before giving up.
	<h2>Planned features:</h2>
	<ul>
		<li>Save and Publish wordsearches</li>
		<li>Dynamic resizing of grid</li>
		<li>Hide word list</li>
	</ul>

Thanks for trying it out :-)

<%@include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
