SUBDIRS = Commodore ZX-Spectrum

VERSION = 1.4

FILES = \
	README.md \
	NEWS.md \
	screenshot.png \
	Commodore/anykey.d64 \
	Commodore/anykey.d81 \
	Commodore/anykey-pet.d64 \
	Commodore/anykey-64.prg \
	Commodore/anykey-128.prg \
	Commodore/anykey-mega65.prg \
	Commodore/anykey-pet-8k.prg \
	Commodore/anykey-pet-full.prg \
	Commodore/anykey-plus4.prg \
	ZX-Spectrum/anykey-zx48k.tap \
	ZX-Spectrum/anykey-zx48k.tzx

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
	zip -9q ${DISTFILE} ${FILES}
