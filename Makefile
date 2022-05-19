SUBDIRS = src

VERSION = 1.4

FILES = \
	README.md \
	NEWS.md \
	screenshot.png \
	src/anykey.d64 \
	src/anykey.d81 \
	src/anykey-pet.d64 \
	src/anykey-64.prg \
	src/anykey-128.prg \
	src/anykey-mega65.prg \
	src/anykey-pet-8k.prg \
	src/anykey-pet-full.prg \
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
