VERSION = $(shell cat ../version.txt)

Z80ASM = z80asm
ZCC = zcc
COMPRESS_SCREEN = ../scripts/compress-screen
CONVERT_SCREENS = ../scripts/convert-screens

COMPRESS_SCREEN_DEPENDENCIES = \
	../scripts/compress-screen \
	../scripts/AssemblerOutput.py \
	../scripts/RunlengthEncoder.py

CONVERT_SCREENS_DEPENDENCIES = \
	../scripts/convert-screens \
	../scripts/AssemblerOutput.py \
	../scripts/RunlengthEncoder.py \
	../scripts/Screens.py


CFLAGS_48K = +zx -Ca-DPLATFORM_48K
CFLAGS_PLUS = +zx -Ca-DPLATFORM_PLUS
CFLAGS_PLUS2 = +zx -Ca-DPLATFORM_PLUS2
CFLAGS_NEXT = +zxn -Ca-DPLATFORM_NEXT
CFLAGS_N_GO = +zxn -Ca-DPLATFORM_N_GO

PROGRAMS = \
	anykey-spectrum-48k.tzx \
	anykey-spectrum-48k+-128k.tzx \
	anykey-spectrum-+2-+3.tzx \
	anykey-spectrum-next.nex \
	anykey-spectrum-n-go.nex

SOURCES_COMMON = \
	start-zx.asm \
	copy-colors.asm \
	copy-screen.asm \
	display-keyboard.asm \
	help-view.asm \
	main-view.asm \
	read-keyboard.asm \
	reset-keyboard.asm \

SOURCES_COMMON_PLUS2 = \
	button.asm \
	combine-keys.asm \
	dpad.asm \
	joystick.asm \

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
	${SOURCES_COMMON_PLUS2} \
	display-keys-plus2.asm \
	help-screens-plus2.asm \
	keys-plus2.asm \
	platform-plus2.asm

SOURCES_NEXT = \
	${SOURCES_COMMON} \
	${SOURCES_COMMON_PLUS2} \
	display-keys-plus.asm \
	extended-keys.asm \
	help-screens-next.asm \
	keys-plus2.asm \
	platform-next.asm \
	platform-next-class.asm

SOURCES_N_GO = \
	${SOURCES_COMMON} \
	${SOURCES_COMMON_PLUS2} \
	display-keys-plus2.asm \
	extended-keys.asm \
	help-screens-n-go.asm \
	keys-n-go.asm \
	platform-n-go.asm \
	platform-next-class.asm

OBJECTS_48K = ${SOURCES_48K:%.asm=%-48k.o}
OBJECTS_PLUS = ${SOURCES_PLUS:%.asm=%-plus.o}
OBJECTS_PLUS2 = ${SOURCES_PLUS2:%.asm=%-plus2.o}
OBJECTS_NEXT = ${SOURCES_NEXT:%.asm=%-next.o}
OBJECTS_N_GO = ${SOURCES_N_GO:%.asm=%-n-go.o}

ALL_OBJECTS = ${OBJECTS_48K} ${OBJECTS_PLUS} ${OBJECTS_PLUS2} ${OBJECTS_NEXT} ${OBJECTS_N_GO}

all: ${PROGRAMS}

clean:
	rm -f ${ALL_OBJECTS} ${PROGRAMS}

%.tzx: %.tap
	tzxmerge -o $@ $<

%-48k.o: %.asm
	${ZCC} ${CFLAGS_48K} -o $@ -c $<

%-plus.o: %.asm
	${ZCC} ${CFLAGS_PLUS} -o $@ -c $<

%-plus2.o: %.asm
	${ZCC} ${CFLAGS_PLUS2} -o $@ -c $<

%-next.o: %.asm
	${ZCC} ${CFLAGS_NEXT} -o $@ -c $<

%-n-go.o: %.asm
	${ZCC} ${CFLAGS_N_GO} -o $@ -c $<

anykey-spectrum-48k.tap: loading-48k.scr ${OBJECTS_48K}
	${ZCC} +zx -startup=31 -clib=new -pragma-include:zpragma.inc -create-app -m -Cz--screen=loading-48k.scr -o anykey-spectrum-48k ${OBJECTS_48K}

anykey-spectrum-48k+-128k.tap: loading-plus.scr ${OBJECTS_PLUS}
	${ZCC} +zx -startup=31 -clib=new -pragma-include:zpragma.inc -create-app -m -Cz--screen=loading-plus.scr -o anykey-spectrum-48k+-128k ${OBJECTS_PLUS}

anykey-spectrum-+2-+3.tap: loading-plus2.scr ${OBJECTS_PLUS2}
	${ZCC} +zx -startup=31 -clib=new -pragma-include:zpragma.inc -create-app -m -Cz--screen=loading-plus2.scr -o anykey-spectrum-+2-+3 ${OBJECTS_PLUS2}

anykey-spectrum-next.nex: loading-next.scr ${OBJECTS_NEXT}
	${ZCC} +zxn -startup=31 -clib=new -pragma-include:zpragma.inc -create-app -subtype=nex -o anykey-spectrum-next ${OBJECTS_NEXT}

anykey-spectrum-n-go.nex: loading-n-go.scr ${OBJECTS_N_GO}
	${ZCC} +zxn -startup=31 -clib=new -pragma-include:zpragma.inc -create-app -subtype=nex -o anykey-spectrum-n-go ${OBJECTS_N_GO}

loading-48k.scr: loading-48k.png
	gfx-convert -b 7 spectrum $< $@

loading-plus.scr: loading-plus.png
	gfx-convert -b 7 spectrum $< $@

loading-plus2.scr: loading-plus2.png
	gfx-convert -b 7 spectrum $< $@

loading-next.scr: loading-next.png
	gfx-convert -b 7 spectrum $< $@

loading-n-go.scr: loading-n-go.png
	gfx-convert -b 7 spectrum $< $@

charset.bin: charset.png
	gfx-convert -b 255 charset charset.png charset.bin

charset-48k.bin keyboard-48k.bin help-48k.bin: charset.bin keyboard-48k.png help-48k.png
	gfx-convert -b 1 screen charset.bin charset-48k.bin keyboard-48k.png help-48k.png

charset-plus.bin keyboard-plus.bin help-plus.bin: charset.bin keyboard-plus.png help-plus.png
	gfx-convert -b 1 screen charset.bin charset-plus.bin keyboard-plus.png help-plus.png

charset-plus2.bin keyboard-plus2.bin help-plus2.bin: charset.bin keyboard-plus2.png help-plus2.png
	gfx-convert -b 1 screen charset.bin charset-plus2.bin keyboard-plus2.png help-plus2.png

charset-next.bin keyboard-next.bin help-next.bin: charset.bin keyboard-next.png help-next.png
	gfx-convert -b 1 screen charset.bin charset-next.bin keyboard-next.png help-next.png

charset-n-go.bin keyboard-n-go.bin help-n-go.bin: charset.bin keyboard-n-go.png help-n-go.png
	gfx-convert -b 1 screen charset.bin charset-n-go.bin keyboard-n-go.png help-n-go.png

charset-joystick.bin button.bin dpad.bin: button.png dpad.png
	gfx-convert -b 1 screen "" charset-joystick.bin button.png dpad.png

keyboard-48k-rl.bin: keyboard-48k.bin ${COMPRESS_SCREEN_DEPENDENCIES}
	./${COMPRESS_SCREEN} keyboard-48k.bin $@

help-48k-rl.bin: help-48k.bin ${COMPRESS_SCREEN_DEPENDENCIES}
	./${COMPRESS_SCREEN} help-48k.bin $@

keyboard-plus-rl.bin: keyboard-plus.bin ${COMPRESS_SCREEN_DEPENDENCIES}
	./${COMPRESS_SCREEN} keyboard-plus.bin $@

help-plus-rl.bin: help-plus.bin ${COMPRESS_SCREEN_DEPENDENCIES}
	./${COMPRESS_SCREEN} help-plus.bin help-plus-rl.bin

keyboard-plus2-rl.bin: keyboard-plus2.bin ${COMPRESS_SCREEN_DEPENDENCIES}
	./${COMPRESS_SCREEN} keyboard-plus2.bin $@

help-plus2-rl.bin: help-plus2.bin ${COMPRESS_SCREEN_DEPENDENCIES}
	./${COMPRESS_SCREEN} help-plus2.bin help-plus2-rl.bin

keyboard-next-rl.bin: keyboard-next.bin ${COMPRESS_SCREEN_DEPENDENCIES}
	./${COMPRESS_SCREEN} keyboard-next.bin $@

help-next-rl.bin: help-next.bin ${COMPRESS_SCREEN_DEPENDENCIES}
	./${COMPRESS_SCREEN} help-next.bin help-next-rl.bin

keyboard-n-go-rl.bin: keyboard-n-go.bin ${COMPRESS_SCREEN_DEPENDENCIES}
	./${COMPRESS_SCREEN} keyboard-n-go.bin $@

help-n-go-rl.bin: help-n-go.bin ${COMPRESS_SCREEN_DEPENDENCIES}
	./${COMPRESS_SCREEN} help-n-go.bin help-n-go-rl.bin

button.asm: button.json button.bin ${COMPRESS_SCREEN_DEPENDENCIES}
	./${COMPRESS_SCREEN} button.json $@

dpad.asm: dpad.json dpad.bin ${COMPRESS_SCREEN_DEPENDENCIES}
	./${COMPRESS_SCREEN} dpad.json $@

keys-48k.asm: keys-48k.key key-table
	./key-table keys-48k

keys-plus.asm: keys-plus.key key-table
	./key-table keys-plus

keys-plus2.asm: keys-plus2.key key-table
	./key-table keys-plus2

keys-n-go.asm: keys-n-go.key key-table
	./key-table keys-n-go

help-screens-48k.asm: help-screens.txt ../version.txt ${CONVERT_SCREENS_DEPENDENCIES}
	./${CONVERT_SCREENS} -DVERSION=${VERSION} -DPLATFORM_48K help-screens.txt $@

help-screens-plus.asm: help-screens.txt ../version.txt ${CONVERT_SCREENS_DEPENDENCIES}
	./${CONVERT_SCREENS} -DVERSION=${VERSION} -DPLATFORM_PLUS help-screens.txt $@

help-screens-plus2.asm: help-screens.txt ../version.txt ${CONVERT_SCREENS_DEPENDENCIES}
	./${CONVERT_SCREENS} -DVERSION=${VERSION} -DPLATFORM_PLUS2 help-screens.txt $@

help-screens-next.asm: help-screens.txt ../version.txt ${CONVERT_SCREENS_DEPENDENCIES}
	./${CONVERT_SCREENS} -DVERSION=${VERSION} -DPLATFORM_NEXT help-screens.txt $@

help-screens-n-go.asm: help-screens.txt ../version.txt ${CONVERT_SCREENS_DEPENDENCIES}
	./${CONVERT_SCREENS} -DVERSION=${VERSION} -DPLATFORM_N_GO help-screens.txt $@

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
display-keyboard-plus2.o: display-keyboard.asm keyboard.inc platform.inc platform-plus2.inc
main-view-plus2.o: main-view.asm keyboard.inc platform.inc platform-plus2.inc
platform-plus2-plus2.o: platform-plus2.asm platform.inc platform-plus2.inc charset-plus2.bin keyboard-plus2-rl.bin help-plus2-rl.bin
read-keyboard-plus2.o: read-keyboard.asm platform.inc platform-plus2.inc keyboard.inc
reset-keyboard-plus2.o: reset-keyboard.asm platform.inc platform-plus2.inc
start-zx-plus2.o: start-zx.asm platform.inc platform-plus2.inc

combine-keys-next.o: combine-keys.asm platform.inc platform-next.inc keyboard.inc
copy-colors-next.o: copy-colors.asm platform.inc platform-next.inc
copy-screen-next.o: copy-screen.asm platform.inc platform-next.inc
display-keys-plus-next.o: display-keys-plus.asm keyboard.inc platform-next.inc
extended-keys-next.o: extended-keys.asm keyboard.inc platform.inc platform-n-go.inc platform-next-class.inc
help-view-next.o: help-view.asm platform.inc keyboard.inc platform-next.inc
joystick-next.o: joystick.asm charset-joystick.bin platform.inc platform-next.inc
display-keyboard-next.o: display-keyboard.asm keyboard.inc platform.inc platform-next.inc
main-view-next.o: main-view.asm keyboard.inc platform.inc platform-next.inc
platform-next-next.o: platform-next.asm platform.inc platform-next.inc charset-next.bin keyboard-next-rl.bin help-next-rl.bin
read-keyboard-next.o: read-keyboard.asm platform.inc platform-next.inc keyboard.inc
reset-keyboard-next.o: reset-keyboard.asm platform.inc platform-next.inc
start-zx-next.o: start-zx.asm platform.inc platform-next.inc

combine-keys-n-go.o: combine-keys.asm platform.inc platform-n-go.inc keyboard.inc
copy-colors-n-go.o: copy-colors.asm platform.inc platform-n-go.inc
copy-screen-n-go.o: copy-screen.asm platform.inc platform-n-go.inc
display-keys-plus2-n-go.o: display-keys-plus2.asm keyboard.inc platform-n-go.inc
extended-keys-n-go.o: extended-keys.asm keyboard.inc platform.inc platform-n-go.inc platform-next-class.inc
help-view-n-go.o: help-view.asm platform.inc keyboard.inc platform-n-go.inc
joystick-n-go.o: joystick.asm charset-joystick.bin platform.inc platform-n-go.inc
display-keyboard-n-go.o: display-keyboard.asm keyboard.inc platform.inc platform-n-go.inc
main-view-n-go.o: main-view.asm keyboard.inc platform.inc platform-n-go.inc
platform-n-go-n-go.o: platform-n-go.asm platform.inc platform-n-go.inc charset-n-go.bin keyboard-n-go-rl.bin help-n-go-rl.bin
read-keyboard-n-go.o: read-keyboard.asm platform.inc platform-n-go.inc keyboard.inc
reset-keyboard-n-go.o: reset-keyboard.asm platform.inc platform-n-go.inc
start-zx-n-go.o: start-zx.asm platform.inc platform-n-go.inc
