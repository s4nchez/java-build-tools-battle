SRCDIR=src/main/java
OUTDIR=out/make
MAIN_CLASS=com.github.s4nchez.playground.HelloUtterlyIdle
SRCS:=$(shell find $(SRCDIR) -name '*.java')
JAR=out/classes.jar
FATJAR=out/java-playground.jar

pathify = $(subst $(eval) ,:,$1)

.PHONY: deps
deps: make/build.dependencies make/shavenmaven.jar
	java -jar make/shavenmaven.jar make lib

.PHONY: jar
jar: $(FATJAR)

$(FATJAR): $(SRCS)
	$(eval TMP := $(call pathify,$(wildcard lib/build/*.jar)))
	@mkdir -p $(OUTDIR)/classes
	javac -source 1.7 -cp $(call pathify,$(wildcard lib/build/*.jar)) -d $(OUTDIR)/classes $(SRCS)
	jar cfe $(JAR) $(MAIN_CLASS) -C $(OUTDIR)/classes .
	java -jar make/JarSplicePlus.jar -i $(JAR) $(wildcard lib/build/*.jar) -o $@ -m $(MAIN_CLASS)

.PHONY: clean
clean:
	rm -rf $(OUTDIR) $(JAR) $(FATJAR) lib

.PHONY:
all: deps jar

.PHONY:
again: clean all
