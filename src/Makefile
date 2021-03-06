DEPDIR := .deps

CC = cl65
CFLAGS_64 = -t c64
CFLAGS_128 = -t c128
CFLAGS_PLUS4 = -t plus4

LD = cl65
LDFLAGS_64 = -t c64 -u __EXEHDR__ -C c64-asm.cfg
LDFLAGS_128 = -t c128 -u __EXEHDR__ -C c128-asm.cfg
LDFLAGS_PLUS4 = -t plus4 -u __EXEHDR__ -C plus4-asm.cfg
LDFLAGS_VIC20 = -t vic20 -u __EXEHDR__ -C vic20-asm.cfg
# LDFLAGS_64 += -Ln sym
# LDFLAGS_128 += -Ln sym
# LDFLAGS_PLUS4 += -Ln sym
# LDFLAGS_VIC20 += -Ln sym

DISK = anykey.d64
PROGRAMS = anykey.prg anykey-64.prg anykey-128.prg anykey-plus4.prg

SOURCES_COMMON = \
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
	keyboard.s \
	help-screen.s \
	main-loop.s \
	memcpy.s \
	screen.s \
	state.s \

SOURCES_VICII = \
	start-vicii.s \
	help-vicii.s \
	joysticks-vicii.s \
	keyboard-vicii.s \
	logo.s \
	sprite.s \
	sprites.s \
	switch-vicii.s
	
SOURCES_128 = \
	${SOURCES_VICII} \
	${SOURCES_COMMON} \
	charset-128.s \
	irq-table-128.s \
	keys-128.s \
	screen-128.s

SOURCES_64 = \
	${SOURCES_128} \
	charset-64.s \
	irq-table-64.s \
	keys-64.s \
	screen-64.s

SOURCES_TED = \
	start-ted.s \
	help-ted.s \
	joysticks-ted.s \
	switch-ted.s


SOURCES_PLUS4 = \
	${SOURCES_TED} \
	${SOURCES_COMMON} \
	charset-plus4.s \
	keys-plus4.s \
	irq-table-plus4.s \
	screen-plus4.s

OBJECTS_64 = ${SOURCES_64:%.s=%-64.o}
OBJECTS_128 = ${SOURCES_128:%.s=%-128.o}
OBJECTS_PLUS4 = ${SOURCES_PLUS4:%.s=%-plus4.o}

ALL_OBJECTS = ${OBJECTS_64} ${OBJECTS_128} ${OBJECTS_PLUS4}

all: ${PROGRAMS} ${DISK}

clean:
	rm -f ${ALL_OBJECTS} ${PROGRAMS}


%-64.o : %.s ${DEPDIR}/%-64.o.d | ${DEPDIR}
	${CC} -o $@ ${CFLAGS_64} --create-dep ${DEPDIR}/$@.d -c $<

%-128.o : %.s ${DEPDIR}/%-128.o.d | ${DEPDIR}
	${CC} -o $@ ${CFLAGS_128} --create-dep ${DEPDIR}/$@.d -c $<

%-plus4.o : %.s ${DEPDIR}/%-plus4.o.d | ${DEPDIR}
	${CC} -o $@ ${CFLAGS_PLUS4} --create-dep ${DEPDIR}/$@.d -c $<

${DEPDIR}: ; @mkdir -p $@

DEPFILES := ${ALL_OBJECTS:%=${DEPDIR}/%.d}
${DEPFILES}:

include $(wildcard ${DEPFILES})

${DISK}: ${PROGRAMS}
	disk=${DISK}.$$$$; \
	(set -e; \
	c1541 -silent -format "anykey,tp" d64 $$disk; \
	c1541 $$disk -silent -write "anykey.prg" "anykey"; \
	c1541 $$disk -silent -write "anykey-64.prg" "anykey 64"; \
	c1541 $$disk -silent -write "anykey-128.prg" "anykey 128"; \
	c1541 $$disk -silent -write "anykey-plus4.prg" "anykey plus/4"; \
	ips_util apply comma8.ips $$disk -o ${DISK}); \
	rm $$disk

anykey.prg: anykey.bas
	petcat -w3 -l 0801 -o anykey.prg anykey.bas
	
anykey-64.prg: ${OBJECTS_64}
	${LD} ${LDFLAGS_64} -o anykey-64.prg ${OBJECTS_64}

anykey-128.prg: ${OBJECTS_128}
	${LD} ${LDFLAGS_128} -o anykey-128.prg ${OBJECTS_128}

anykey-plus4.prg: ${OBJECTS_PLUS4}
	${LD} ${LDFLAGS_PLUS4} -o anykey-plus4.prg ${OBJECTS_PLUS4}

keys-64.s: keys-64.key key-table
	./key-table keys-64

keys-128.s: keys-128.key key-table
	./key-table keys-128

keys-plus4.s: keys-plus4.key key-table
	./key-table keys-plus4

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

keyboard-plus4-normal-bitmap.bin: keyboard-plus4-normal.png
	gfx-convert -b 1 bitmap keyboard-plus4-normal.png keyboard-plus4-normal

keyboard-plus4-pressed-bitmap.bin: keyboard-plus4-pressed.png
	gfx-convert -b 1 bitmap keyboard-plus4-pressed.png keyboard-plus4-pressed

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
