ZCC = zcc

CFLAGS_48K = -Ca-DPLATFORM_48K
CFLAGS_PLUS = -Ca-DPLATFORM_PLUS

PROGRAMS = \
	anykey-spectrum-48k.tzx \
	anykey-spectrum-48k+-128k.tzx

SOURCES_COMMON = \
	start-zx.asm \
	copy-colors.asm \
	copy-screen.asm \
	display-keyboard.asm \
	help-view.asm \
	main-view.asm \
	read-keyboard.asm \
	reset-keyboard.asm \

SOURCES_48K = \
	${SOURCES_COMMON} \
	display-keys-48k.asm \
	help-screens-48k.asm \
	keys-48k.asm \
	platform-48k.asm

SOURCES_PLUS = \
	${SOURCES_COMMON} \
	combine-keys.asm \
	display-keys-plus.asm \
	help-screens-plus.asm \
	keys-plus.asm \
	platform-plus.asm

OBJECTS_48K = ${SOURCES_48K:%.asm=%-48k.o}
OBJECTS_PLUS = ${SOURCES_PLUS:%.asm=%-plus.o}

ALL_OBJECTS = ${OBJECTS_48K} ${OBJECTS_PLUS}

all: ${PROGRAMS}

clean:
	rm -f ${ALL_OBJECTS} ${PROGRAMS}

%.tzx: %.tap
	tzxmerge -o $@ $<

%-48k.o: %.asm
	zcc +zx ${CFLAGS_48K} -o $@ -c $<

%-plus.o: %.asm
	zcc +zx ${CFLAGS_PLUS} -o $@ -c $<

anykey-spectrum-48k.tap: loading-48k.scr ${OBJECTS_48K}
	zcc +zx -startup=31 -clib=new -pragma-include:zpragma.inc -create-app -m -Cz--screen=loading-48k.scr -o anykey-spectrum-48k ${OBJECTS_48K}

anykey-spectrum-48k+-128k.tap: loading-plus.scr ${OBJECTS_PLUS}
	zcc +zx -startup=31 -clib=new -pragma-include:zpragma.inc -create-app -m -Cz--screen=loading-plus.scr -o anykey-spectrum-48k+-128k ${OBJECTS_PLUS}

loading-48k.scr: loading-48k.png
	gfx-convert -b 7 spectrum $< $@

loading-128.scr: loading-128k.png
	gfx-convert -b 7 spectrum $< $@

loading-plus.scr: loading-plus.png
	gfx-convert -b 7 spectrum $< $@

charset.bin: charset.png
	gfx-convert -b 255 charset charset.png charset.bin

charset-48k.bin keyboard-48k.bin help-48k.bin: charset.bin keyboard-48k.png help-48k.png
	gfx-convert -b 1 screen charset.bin charset-48k.bin keyboard-48k.png help-48k.png

charset-plus.bin keyboard-plus.bin help-plus.bin: charset.bin keyboard-plus.png help-plus.png
	gfx-convert -b 1 screen charset.bin charset-plus.bin keyboard-plus.png help-plus.png

keyboard-48k-rl.bin: keyboard-48k.bin compress-screen
	./compress-screen keyboard-48k.bin $@

help-48k-rl.bin: help-48k.bin compress-screen
	./compress-screen help-48k.bin $@

keyboard-plus-rl.bin: keyboard-plus.bin compress-screen
	./compress-screen keyboard-plus.bin $@

help-plus-rl.bin: help-plus.bin compress-screen
	./compress-screen help-plus.bin help-plus-rl.bin

keys-48k.asm: keys-48k.key key-table
	./key-table keys-48k

keys-plus.asm: keys-plus.key key-table
	./key-table keys-plus

help-screens-48k.asm: help-screens.txt compress-screen
	./compress-screen -DPLATFORM_48K help-screens.txt $@

help-screens-plus.asm: help-screens.txt compress-screen
	./compress-screen -DPLATFORM_PLUS help-screens.txt $@

# TODO: auto track dependencies

copy-colors-48k.o: copy-colors.asm platform.inc platform-48k.inc
copy-screen-48k.o: copy-screen.asm platform.inc platform-48k.inc
display-keyboard-48k.o: display-keys-48k.asm keyboard.inc platform-48k.inc
help-view-48k.o: help-view.asm platform.inc keyboard.inc platform-48k.inc
keyboard-48k.o: display-keyboard.asm keyboard.inc platform.inc platform-48k.inc
main-view-48k.o: main-view.asm keyboard.inc platform.inc platform-48k.inc
platform-48k-48k.o: platform-48k.asm platform.inc platform-48k.inc charset-48k.bin keyboard-48k-rl.bin help-48k-rl.bin
read-keyboard-48k.o: read-keyboard.asm platform.inc keyboard.inc platform-48k.inc
reset-keyboard-48k.o: reset-keyboard.asm platform.inc platform-48k.inc
start-zx-48k.o: start-zx.asm platform.inc platform-48k.inc

combine-keys-plus.o: combine-keys.asm platform.inc platform-plus.inc keyboard.inc
copy-colors-plus.o: copy-colors.asm platform.inc platform-plus.inc
copy-screen-plus.o: copy-screen.asm platform.inc platform-plus.inc
display-keyboard-plus.o: display-keys-plus.asm keyboard.inc platform-plus.inc
help-view-plus.o: help-view.asm platform.inc keyboard.inc platform-plus.inc
keyboard-plus.o: display-keyboard.asm keyboard.inc platform.inc platform-plus.inc
main-view-plus.o: main-view.asm keyboard.inc platform.inc platform-plus.inc
platform-plus-plus.o: platform-plus.asm platform.inc platform-plus.inc charset-plus.bin keyboard-plus-rl.bin help-plus-rl.bin
read-keyboard-plus.o: read-keyboard.asm platform.inc platform-plus.inc keyboard.inc
reset-keyboard-plus.o: reset-keyboard.asm platform.inc platform-plus.inc
start-zx-plus.o: start-zx.asm platform.inc platform-plus.inc
