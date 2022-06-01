SUBDIRS = Commodore ZX-Spectrum

VERSION = $(shell cat version.txt)

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
	ZX-Spectrum/anykey-spectrum-48k.tap \
	ZX-Spectrum/anykey-spectrum-48k.tzx \
	ZX-Spectrum/anykey-spectrum-48k+-128k.tap \
	ZX-Spectrum/anykey-spectrum-48k+-128k.tzx \
	ZX-Spectrum/anykey-spectrum-+2-+3.tap \
	ZX-Spectrum/anykey-spectrum-+2-+3.tzx \
	ZX-Spectrum/anykey-spectrum-next.tap \
	ZX-Spectrum/anykey-spectrum-next.tzx \
	ZX-Spectrum/anykey-spectrum-n-go.tap \
	ZX-Spectrum/anykey-spectrum-n-go.tzx \
	Documentation

DISTFILE = Anykey-${VERSION}.zip

.PHONY: all clean dist

all:
	@for dir in ${SUBDIRS}; \
	do \
		(cd $$dir && make all) || exit 1; \
	done

dist: all ${DISTFILE}

clean:
	@for dir in ${SUBDIRS}; \
	do \
		(cd $$dir && make clean) || exit 1; \
	done

${DISTFILE}: ${FILES}
	zip -9rq ${DISTFILE} ${FILES}
