JAVA  = /usr/bin/java
# JAVAFLAGS = -version # -classpath $(LIBS)
JAVAC = /usr/bin/javac
JFLAGS = -g # -classpath $(LIBS)

SRCS = uk/org/mafoo/wordsearch/GridFactory.java \
	uk/org/mafoo/wordsearch/Bounds.java \
	uk/org/mafoo/wordsearch/CouldNotPlaceWordException.java \
	uk/org/mafoo/wordsearch/Direction.java \
	uk/org/mafoo/wordsearch/DistributedRandomNumberGenerator.java \
	uk/org/mafoo/wordsearch/Modes.java

OBJS = ${SRCS:.java=.class}

.SUFFIXES: .java .class

all: build wordsearch.jar

run: all
	$(JAVA) uk.org.mafoo.wordsearch.GridFactory 10 10

.java.class:
	$(JAVAC) $(JFLAGS) $<

build: $(OBJS)

clean:
	rm -f $(OBJS) wordsearch.jar wordsearch.war

wordsearch.jar: build
	jar cf $@ $(OBJS)
	cp wordsearch.jar war/WEB-INF/lib
