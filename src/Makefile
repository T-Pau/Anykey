DEPDIR := .deps

CC = cl65
CFLAGS_64 = -t c64
CFLAGS_128 = -t c128

LD = cl65
LDFLAGS_64 = -t c64 -u __EXEHDR__ -C c64-asm.cfg
LDFLAGS_128 = -t c128 -u __EXEHDR__ -C c128-asm.cfg
# LDFLAGS_64 += -Ln sym
# LDFLAGS_128 += -Ln sym

PROGRAMS = anykey-64.prg anykey-128.prg

SOURCES_COMMON = \
	start.s \
	button.s \
	charset.s \
	colors.s \
	commands.s \
	copyrect.s \
	display-joystick.s \
	display-key.s \
	dpad.s \
	irq.s \
	irq-table.s \
	joysticks.s \
	keyboard.s \
	logo.s \
	help.s \
	help-screen.s \
	main-loop.s \
	memcpy.s \
	screen.s \
	sprite.s \
	sprites.s \
	state.s \
	switch.s

SOURCES_64 = \
	${SOURCES_COMMON} \
	charset-64.s \
	charset-128.s \
	keys-64.s \
	keys-128.s \
	screen-64.s \
	screen-128.s

SOURCES_128 = \
	${SOURCES_COMMON} \
	charset-128.s \
	keys-128.s \
	screen-128.s

SOURCES_PLUS4 = \
	${SOURCES_COMMON} \
	charset-plus4.s \
	keys-plus4.s \
	screen-plus4.s

OBJECTS_64 = ${SOURCES_64:%.s=%-64.o}
OBJECTS_128 = ${SOURCES_128:%.s=%-128.o}

ALL_OBJECTS = ${OBJECTS_64} ${OBJECTS_128}

all: ${PROGRAMS}

clean:
	rm -f ${ALL_OBJECTS} ${PROGRAMS}


%-64.o : %.s ${DEPDIR}/%-64.o.d | ${DEPDIR}
	${CC} -o $@ ${CFLAGS_64} --create-dep ${DEPDIR}/$@.d -c $<

%-128.o : %.s ${DEPDIR}/%-128.o.d | ${DEPDIR}
	${CC} -o $@ ${CFLAGS_128} --create-dep ${DEPDIR}/$@.d -c $<

${DEPDIR}: ; @mkdir -p $@

DEPFILES := ${ALL_OBJECTS:%=${DEPDIR}/%.d}
${DEPFILES}:

include $(wildcard ${DEPFILES})

anykey-64.prg: ${OBJECTS_64}
	${LD} ${LDFLAGS_64} -o anykey-64.prg ${OBJECTS_64}

anykey-128.prg: ${OBJECTS_128}
	${LD} ${LDFLAGS_128} -o anykey-128.prg ${OBJECTS_128}


keys-64.s: keys-64.key key-table
	./key-table keys-64

keys-128.s: keys-128.key key-table
	./key-table keys-128

keyboard-64-charset-top.bin keyboard-64-charset-bottom.bin keyboard-64-screen.bin: keyboard-64-normal-bitmap.bin keyboard-64-pressed-bitmap.bin convert-keyboard
	./convert-keyboard keyboard-64 40 12 3

keyboard-128-charset-top.bin keyboard-128-charset-bottom.bin keyboard-128-screen.bin: keyboard-128-normal-bitmap.bin keyboard-128-pressed-bitmap.bin convert-keyboard
	./convert-keyboard keyboard-128 40 14 6
	
keyboard-plus4-charset-top.bin keyboard-plus4-charset-bottom.bin keyboard-plus4-screen.bin: keyboard-plus4-normal-bitmap.bin keyboard-plus4-pressed-bitmap.bin convert-keyboard
	./convert-keyboard keyboard-plus4 36 14 4


keyboard-64-pressed-bitmap.bin: keyboard-64-pressed.png
	gfx-convert -b 1 bitmap keyboard-64-pressed.png  keyboard-64-pressed

keyboard-64-normal-bitmap.bin: keyboard-64-normal.png
	gfx-convert -b 1 bitmap keyboard-64-normal.png  keyboard-64-normal

keyboard-128-normal-bitmap.bin: keyboard-128-normal.png
	gfx-convert -b 1 bitmap keyboard-128-normal.png keyboard-128-normal

keyboard-128-pressed-bitmap.bin: keyboard-128-pressed.png
	gfx-convert -b 1 bitmap keyboard-128-pressed.png keyboard-128-pressed

charset.bin: charset.png
	gfx-convert -b 255 charset charset.png charset.bin

sprites.bin: sprites.png
	gfx-convert sprites sprites.png sprites.bin

dpad.bin: dpad.png charset.bin
	gfx-convert screen dpad.png charset.bin dpad.bin


charset.o: charset.bin keyboard-64-charset-top.bin keyboard-64-charset-bottom.bin keyboard-128-charset-top.bin keyboard-128-charset-bottom.bin
dpad.o: dpad.bin
screen.o: keyboard-64-screen.bin keyboard-128-screen.bin
sprites.o: sprites.bin
