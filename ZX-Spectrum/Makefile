ZCC = zcc

CFLAGS_48K = -Ca-DPLATFORM_48K
CFLAGS_PLUS = -Ca-DPLATFORM_PLUS
CFLAGS_PLUS2 = -Ca-DPLATFORM_PLUS2

PROGRAMS = \
	anykey-spectrum-48k.tzx \
	anykey-spectrum-48k+-128k.tzx \
	anykey-spectrum-+2-+3.tzx

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

SOURCES_PLUS2 = \
	${SOURCES_COMMON} \
	button.asm \
	combine-keys.asm \
	dpad.asm \
	joystick.asm \
	display-keys-plus2.asm \
	help-screens-plus2.asm \
	keys-plus2.asm \
	platform-plus2.asm


OBJECTS_48K = ${SOURCES_48K:%.asm=%-48k.o}
OBJECTS_PLUS = ${SOURCES_PLUS:%.asm=%-plus.o}
OBJECTS_PLUS2 = ${SOURCES_PLUS2:%.asm=%-plus2.o}

ALL_OBJECTS = ${OBJECTS_48K} ${OBJECTS_PLUS} ${OBJECTS_PLUS2}

all: ${PROGRAMS}

clean:
	rm -f ${ALL_OBJECTS} ${PROGRAMS}

%.tzx: %.tap
	tzxmerge -o $@ $<

%-48k.o: %.asm
	zcc +zx ${CFLAGS_48K} -o $@ -c $<

%-plus.o: %.asm
	zcc +zx ${CFLAGS_PLUS} -o $@ -c $<

%-plus2.o: %.asm
	zcc +zx ${CFLAGS_PLUS2} -o $@ -c $<

anykey-spectrum-48k.tap: loading-48k.scr ${OBJECTS_48K}
	zcc +zx -startup=31 -clib=new -pragma-include:zpragma.inc -create-app -m -Cz--screen=loading-48k.scr -o anykey-spectrum-48k ${OBJECTS_48K}

anykey-spectrum-48k+-128k.tap: loading-plus.scr ${OBJECTS_PLUS}
	zcc +zx -startup=31 -clib=new -pragma-include:zpragma.inc -create-app -m -Cz--screen=loading-plus.scr -o anykey-spectrum-48k+-128k ${OBJECTS_PLUS}

anykey-spectrum-+2-+3.tap: loading-plus2.scr ${OBJECTS_PLUS2}
	zcc +zx -startup=31 -clib=new -pragma-include:zpragma.inc -create-app -m -Cz--screen=loading-plus2.scr -o anykey-spectrum-+2-+3 ${OBJECTS_PLUS2}

loading-48k.scr: loading-48k.png
	gfx-convert -b 7 spectrum $< $@

loading-plus.scr: loading-plus.png
	gfx-convert -b 7 spectrum $< $@

loading-plus2.scr: loading-plus2.png
	gfx-convert -b 7 spectrum $< $@

charset.bin: charset.png
	gfx-convert -b 255 charset charset.png charset.bin

charset-48k.bin keyboard-48k.bin help-48k.bin: charset.bin keyboard-48k.png help-48k.png
	gfx-convert -b 1 screen charset.bin charset-48k.bin keyboard-48k.png help-48k.png

charset-plus.bin keyboard-plus.bin help-plus.bin: charset.bin keyboard-plus.png help-plus.png
	gfx-convert -b 1 screen charset.bin charset-plus.bin keyboard-plus.png help-plus.png

charset-plus2.bin keyboard-plus2.bin help-plus2.bin: charset.bin keyboard-plus2.png help-plus2.png
	gfx-convert -b 1 screen charset.bin charset-plus2.bin keyboard-plus2.png help-plus2.png

charset-joystick.bin button.bin dpad.bin: button.png dpad.png
	gfx-convert -b 1 screen "" charset-joystick.bin button.png dpad.png

keyboard-48k-rl.bin: keyboard-48k.bin compress-screen
	./compress-screen keyboard-48k.bin $@

help-48k-rl.bin: help-48k.bin compress-screen
	./compress-screen help-48k.bin $@

keyboard-plus-rl.bin: keyboard-plus.bin compress-screen
	./compress-screen keyboard-plus.bin $@

help-plus-rl.bin: help-plus.bin compress-screen
	./compress-screen help-plus.bin help-plus-rl.bin

keyboard-plus2-rl.bin: keyboard-plus2.bin compress-screen
	./compress-screen keyboard-plus2.bin $@

help-plus2-rl.bin: help-plus2.bin compress-screen
	./compress-screen help-plus2.bin help-plus2-rl.bin

button.asm: button.json button.bin compress-screen
	./compress-screen button.json $@

dpad.asm: dpad.json dpad.bin compress-screen
	./compress-screen dpad.json $@

keys-48k.asm: keys-48k.key key-table
	./key-table keys-48k

keys-plus.asm: keys-plus.key key-table
	./key-table keys-plus

keys-plus2.asm: keys-plus2.key key-table
	./key-table keys-plus2

help-screens-48k.asm: help-screens.txt compress-screen
	./compress-screen -DPLATFORM_48K help-screens.txt $@

help-screens-plus.asm: help-screens.txt compress-screen
	./compress-screen -DPLATFORM_PLUS help-screens.txt $@

help-screens-plus2.asm: help-screens.txt compress-screen
	./compress-screen -DPLATFORM_PLUS2 help-screens.txt $@

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

combine-keys-plus2.o: combine-keys.asm platform.inc platform-plus2.inc keyboard.inc
copy-colors-plus2.o: copy-colors.asm platform.inc platform-plus2.inc
copy-screen-plus2.o: copy-screen.asm platform.inc platform-plus2.inc
display-keyboard-plus2.o: display-keys-plus2.asm keyboard.inc platform-plus2.inc
help-view-plus2.o: help-view.asm platform.inc keyboard.inc platform-plus2.inc
joystick-plus2.o: joystick.asm charset-joystick.bin platform.inc platform-plus2.inc
keyboard-plus2.o: display-keyboard.asm keyboard.inc platform.inc platform-plus2.inc
main-view-plus2.o: main-view.asm keyboard.inc platform.inc platform-plus2.inc
platform-plus2.plus.o: platform-plus2.asm platform.inc platform-plus2.inc charset-plus2.bin keyboard-plus2-rl.bin help-plus2-rl.bin
read-keyboard-plus2.o: read-keyboard.asm platform.inc platform-plus2.inc keyboard.inc
reset-keyboard-plus2.o: reset-keyboard.asm platform.inc platform-plus2.inc
start-zx-plus2.o: start-zx.asm platform.inc platform-plus2.inc
