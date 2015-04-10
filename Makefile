SRCDIR=src/main/java
OUTDIR=out/make
MAIN_CLASS=com.github.s4nchez.playground.HelloUtterlyIdle

SRCS:=$(shell find $(SRCDIR) -name '*.java')
JAR=out/example.jar
BUILD_DEPS:=$(wildcard lib/build/*.jar)
RUNTIME_DEPS:=$(wildcard lib/runtime/*.jar)

pathify = $(subst $(eval) ,:,$1)

.PHONY: deps
deps: make/build.dependencies make/shavenmaven.jar
	java -jar make/shavenmaven.jar make lib

.PHONY: all
all: $(JAR)

$(JAR): $(SRCS) $(BUILD_DEPS) $(OUTDIR)/manifest.mf
	@mkdir -p $(OUTDIR)/classes
	javac -source 1.6 -cp $(call pathify,$(BUILD_DEPS)) -d $(OUTDIR)/classes $(SRCS)
	jar cfme $@ $(OUTDIR)/manifest.mf $(MAIN_CLASS) -C $(OUTDIR)/classes .

$(OUTDIR)/manifest.mf: $(LIBS)
	@mkdir -p $(dir $@)
	echo "Class-Path: $(RUNTIME_DEPS:%=../%)" > $@

.PHONY: clean
clean:
	rm -rf $(OUTDIR) $(JAR)

.PHONY:
again: clean all