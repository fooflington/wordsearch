JAVA  = /usr/bin/java
# JAVAFLAGS = -version # -classpath $(LIBS)
JAVAC = /usr/bin/javac
JFLAGS = -g # -classpath $(LIBS)

SRCS = uk/org/mafoo/wordsearch/CouldNotPlaceWordException.java \
       uk/org/mafoo/wordsearch/Bounds.java \
       uk/org/mafoo/wordsearch/GridFactory.java \
       uk/org/mafoo/wordsearch/DistributedRandomNumberGenerator.java \
       uk/org/mafoo/wordsearch/Direction.java

JSPS = $(wildcard war/*.jsp war/*.css)

OBJS = ${SRCS:.java=.class}

.SUFFIXES: .java .class

.PHONY: default clean
default: wordsearch.war

clean:
	rm -f $(OBJS) wordsearch.jar wordsearch.war

.java.class:
	$(JAVAC) $(JFLAGS) $<

wordsearch.jar: $(OBJS)
	jar cf $@ $(OBJS)

wordsearch.war: wordsearch.jar
	cp -f wordsearch.jar war/lib
	jar -c -f $@ -C war .