DEPDIR := .deps

CC = cl65
CFLAGS = -t c64

LD = cl65
LDFLAGS = -t c64 -u __EXEHDR__ -C c64-asm.cfg
# LDFLAGS += -Ln sym

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


keyboard-charset-top.bin keyboard-charset-bottom.bin keyboard-screen.bin: keyboard-normal-bitmap.bin keyboard-pressed-bitmap.bin convert-keyboard
	./convert-keyboard 3

keyboard-pressed-bitmap.bin: keyboard-pressed.png
	gfx-convert -b 1 bitmap keyboard-pressed.png  keyboard-pressed

keyboard-normal-bitmap.bin: keyboard-normal.png
	gfx-convert -b 1 bitmap keyboard-normal.png  keyboard-normal

charset.bin: charset.png
	gfx-convert -b 255 charset charset.png charset.bin

sprites.bin: sprites.png
	gfx-convert sprites sprites.png sprites.bin

dpad.bin: dpad.png charset.bin
	gfx-convert screen dpad.png charset.bin dpad.bin

${PROGRAM}: ${OBJECTS}
	${LD} ${LDFLAGS} -o ${PROGRAM} ${OBJECTS}


charset.o: charset.bin keyboard-charset-top.bin keyboard-charset-bottom.bin
dpad.o: dpad.bin
screen.o: keyboard-screen.bin
sprites.o: sprites.bin
