SUBDIRS = src

VERSION = 1.2

FILES = \
	README.md \
	NEWS.md \
	Anykey\ User\ Manual.pdf \
	screenshot.png \
	src/anykey-64.prg \
	src/anykey-128.prg \
	src/anykey-plus4.prg

DISTFILE = Anykey-${VERSION}.zip

.PHONY: all clean dist

all:
	@for dir in ${SUBDIRS}; \
	do \
		(cd $$dir && make VERSION="${VERSION}" all) || exit 1; \
	done

dist: ${DISTFILE}

clean:
	@for dir in ${SUBDIRS}; \
	do \
		(cd $$dir && make clean) || exit 1; \
	done

${DISTFILE}: ${FILES}
	zip -9jq ${DISTFILE} ${FILES}
