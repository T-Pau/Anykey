ZCC = zcc

PROGRAMS = \
	anykey-zx48k.tap

SOURCES_48K = \
	start-zx.asm \
	copy-colors.asm \
	copy-screen.asm \
	display-keys.asm \
	display-keyboard.asm \
	keys-48k.asm \
	read-keyboard.asm \
	platform-48k.asm

OBJECTS_48K = ${SOURCES_48K:%.asm=%-48k.o}

ALL_OBJECTS = ${OBJECTS_48K}

all: ${PROGRAMS}

clean:
	rm -f ${ALL_OBJECTS} ${PROGRAMS}

%-48k.o : %.asm
	zcc +zx -o $@ -c $<

# zcc +zx -vn -startup=31 -clib=new -O3 terminals_x2.c -o terminals_x2 -pragma-include:zpragma.inc -create-app
anykey-zx48k.tap: loading-48k.scr ${OBJECTS_48K}
	zcc +zx -startup=31 -clib=new -pragma-include:zpragma.inc -create-app -m -Cz--screen=loading-48k.scr -o anykey-zx48k ${OBJECTS_48K}


loading-48k.scr: loading-48k.png
	gfx-convert -b 7 spectrum loading-48k.png loading-48k.scr

charset.bin: charset.png
	gfx-convert -b 255 charset charset.png charset.bin

charset-48k.bin keyboard-48k.bin: charset.bin keyboard-48k.png
	gfx-convert -b 1 screen charset.bin charset-48k.bin keyboard-48k.png

keys-48k.asm: keys-48k.key key-table
	./key-table keys-48k

# TODO: auto track dependencies

copy-colors-48k.o: copy-colors.asm platform.inc
copy-screen-48k.o: copy-screen.asm platform.inc
display-keyboard-48k.o: display-keys.asm keyboard.inc
keyboard-48k.o: display-keyboard.asm keyboard.inc platform.inc
platform-48k-48k.o: platform-48k.asm platform.inc charset-48k.bin keyboard-48k.bin
read-keyboard-48k.o: read-keyboard.asm platform.inc keyboard.inc
start-zx-48k.o: start-zx.asm platform.inc keyboard.inc
