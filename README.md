Wordsearch
==========

Compiling
---------

A simple ```Makefile``` is provided:

```
$ make
```

Once built, you need to make a "war" file to deploy to your J2EE container (tested on Tomcat)

```
$ cd war && jar cfv ../wordsearch.war .
```

Then deploy your war file :-)
