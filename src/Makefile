DEPDIR := .deps

CC = cl65
CFLAGS = -t c64

LD = cl65
LDFLAGS = -t c64 -u __EXEHDR__ -C c64-asm.cfg
 LDFLAGS += -Ln sym

PROGRAM = anykey.prg

SOURCES = \
	start.s \
	button.s \
	charset.s \
	color.s \
	colors.s \
	commands.s \
	copyrect.s \
	display-joystick.s \
	display-key.s \
	dpad.s \
	irq.s \
	irq-table.s \
	joysticks.s \
	keys-64.s \
	keys-128.s \
	keyboard.s \
	logo.s \
	help.s \
	help-screen.s \
	main-loop.s \
	memcpy.s \
	memset.s \
	screen.s \
	sprite.s \
	sprites.s \
	state.s \
	switch.s

OBJECTS = ${SOURCES:.s=.o}

all: ${PROGRAM}

clean:
	rm -f ${OBJECTS} ${PROGRAM}


%.o : %.s ${DEPDIR}/%.d | ${DEPDIR}
	${CC} ${CFLAGS} --create-dep ${DEPDIR}/$*.d -c $<

${DEPDIR}: ; @mkdir -p $@

DEPFILES := ${SOURCES:%.s=${DEPDIR}/%.d}
${DEPFILES}:

include $(wildcard ${DEPFILES})

keys-64.s: keys-64.key key-table
	./key-table keys-64

keys-128.s: keys-128.key key-table
	./key-table keys-128

keyboard-64-charset-top.bin keyboard-64-charset-bottom.bin keyboard-64-screen.bin: keyboard-64-normal-bitmap.bin keyboard-64-pressed-bitmap.bin convert-keyboard
	./convert-keyboard keyboard-64 12 3

keyboard-128-charset-top.bin keyboard-128-charset-bottom.bin keyboard-128-screen.bin: keyboard-128-normal-bitmap.bin keyboard-128-pressed-bitmap.bin convert-keyboard
	./convert-keyboard keyboard-128 14 6

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

${PROGRAM}: ${OBJECTS}
	${LD} ${LDFLAGS} -o ${PROGRAM} ${OBJECTS}


charset.o: charset.bin keyboard-64-charset-top.bin keyboard-64-charset-bottom.bin keyboard-128-charset-top.bin keyboard-128-charset-bottom.bin
dpad.o: dpad.bin
screen.o: keyboard-64-screen.bin keyboard-128-screen.bin
sprites.o: sprites.bin
