ZCC = zcc

PROGRAMS = \
	anykey-zx48k.tap

SOURCES_48K = \
	start-zx.s

OBJECTS_48K = ${SOURCES_48K:%.s=%-48k.o}

ALL_OBJECTS = ${OBJECTS_48K}

all: ${PROGRAMS}

clean:
	rm -f ${ALL_OBJECTS} ${PROGRAMS}

%-48k.o : %.s
	zcc +zx -o $@ -c $<

# zcc +zx -vn -startup=31 -clib=new -O3 terminals_x2.c -o terminals_x2 -pragma-include:zpragma.inc -create-app
anykey-zx48k.tap: loading-48k.scr ${OBJECTS_48K}
	zcc +zx -startup=31 -clib=new -pragma-include:zpragma.inc -create-app -Cz--screen=loading-48k.scr -o anykey-zx48k ${OBJECTS_48K}


loading-48k.scr: loading-48k.png
	gfx-convert -b 7 spectrum loading-48k.png loading-48k.scr

charset.bin: charset.png
	gfx-convert -b 255 charset charset.png charset.bin

charset-48k.bin keyboard-48k.bin: charset.bin keyboard-48k.png
	gfx-convert screen charset.bin all-chars.bin keyboard-48k.png
