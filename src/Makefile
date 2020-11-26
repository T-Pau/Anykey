CC = cl65
CFLAGS = -t c64

LD = cl65
LDFLAGS = -t c64 -u __EXEHDR__ -C c64-asm.cfg
# LDFLAGS += -Ln sym

PROGRAM = anykey.prg

SOURCES = \


OBJECTS = ${SOURCES:.s=.o}

all: ${PROGRAM}

clean:
	rm -f ${OBJECTS} ${PROGRAM}


.SUFFIXES: .s .o

.s.o:
	${CC} ${CFLAGS} -c $<

keyboard-charset-top.bin keyboard-charset-bottom.bin keyboard-screen.bin: keyboard-normal-bitmap.bin keyboard-pressed-bitmap.bin convert-keyboard
	./convert-keyboard 3

keyboard-pressed-bitmap.bin: keyboard-pressed.png
	gfx-convert -b 1 bitmap keyboard-pressed.png  keyboard-pressed

keyboard-normal-bitmap.bin: keyboard-normal.png
	gfx-convert -b 1 bitmap keyboard-normal.png  keyboard-normal

charset.bin: charset.png
	gfx-convert charset charset.png charset.bin

sprites.bin: sprites.png
	gfx-convert sprites sprites.png sprites.bin

dpad.bin: dpad.png charset.bin
	gfx-convert screen dpad.png charset.bin dpad.bin

lightpen-buttons.bin: lightpen-buttons.png charset.bin
	gfx-convert screen lightpen-buttons.png charset.bin lightpen-buttons.bin

mouse-buttons.bin: mouse-buttons.png charset.bin
	gfx-convert screen mouse-buttons.png charset.bin mouse-buttons.bin

port-screens.bin: port-screens.png charset.bin
	gfx-convert screen port-screens.png charset.bin port-screens.bin \
		&& ./fixup-buttons port-screens.bin

scroll-wheel.bin: scroll-wheel.png charset.bin
	gfx-convert screen scroll-wheel.png charset.bin scroll-wheel.bin

eight-player.bin: eight-player.png charset.bin
	gfx-convert screen eight-player.png charset.bin eight-player.bin


${PROGRAM}: ${OBJECTS}
	${LD} ${LDFLAGS} -o ${PROGRAM} ${OBJECTS}

button.o: button.s joyride.inc
charset.o: charset.s charset.bin
colors.o: colors.s joyride.inc
copyrect.o: copyrect.s joyride.inc
dpad.o: dpad.s joyride.inc dpad.bin
display-joystick.o: display-joystick.s joyride.inc
display-koalapad.o: display-koalapad.s joyride.inc utility.mac
display-lightpen.o: display-lightpen.s joyride.inc utility.mac lightpen-buttons.bin
display-mouse.o: display-mouse.s joyride.inc utility.mac mouse-buttons.bin scroll-wheel.bin
display-paddle.o: display-paddle.s joyride.inc utility.mac
display-port.o: display-port.s joyride.inc
display-raw.o: display-raw.s joyride.inc utility.mac
eight-player.o: eight-player.s joyride.inc utility.mac eight-player.bin
f-keys.o: f-keys.s joyride.inc
help.o: help.s joyride.inc utility.mac
help-screen.o: help-screen.s joyride.inc cbm_ext.mac
irq-table.o: irq-table.s joyride.inc
logo.o: logo.s joyride.inc cbm_ext.mac
memcpy.o: memcpy.s joyride.inc
port-screen.o: port-screen.s joyride.inc cbm_ext.mac utility.mac port-screens.bin
ports.o: ports.s joyride.inc
pot.o: pot.s joyride.inc
screen.o: screen.s joyride.inc cbm_ext.mac utility.mac
snespad.o: snespad.s joyride.inc
sprites.o: sprites.s sprites.bin
start.o: start.s joyride.inc cbm_ext.mac utility.mac
state.o: state.s joyride.inc
superpad.o: superpad.s joyride.inc
userport.o: userport.s joyride.inc cbm_ext.mac
