VERSION = $(shell cat ../version.txt)

CC = CC65_HOME=/usr/local/share/cc65 cl65
LD = CC65_HOME=/usr/local/share/cc65 cl65
CONVERT_SCREENS = ../scripts/convert-screens
CONVERT_KEYBOARD = ../scripts/convert-keyboard

CONVERT_SCREENS_DEPENDENCIES = \
	../scripts/convert-screens \
	../scripts/AssemblerOutput.py \
	../scripts/RunlengthEncoder.py \
	../scripts/Screens.py

CONVERT_KEYBOARD_DEPENDENCIES = \
	../scripts/convert-keyboard \
	../scripts/AssemblerOutput.py \
	../scripts/RunlengthEncoder.py

CFLAGS_64 = -t c64
CFLAGS_128 = -t c128
CFLAGS_MEGA65 = -t mega65
CFLAGS_PET = -t pet
CFLAGS_PLUS4 = -t plus4
CFLAGS_VIC20 = -t vic20

LDFLAGS_64 = -t c64 -u __EXEHDR__ -C c64-asm.cfg
LDFLAGS_128 = -t c128 -u __EXEHDR__ -C c128-asm.cfg
LDFLAGS_MEGA65 = -t mega65 -u __EXEHDR__ -C mega65-asm.cfg
LDFLAGS_PET = -t pet -u __EXEHDR__ -C pet-asm.cfg
LDFLAGS_PLUS4 = -t plus4 -u __EXEHDR__ -C plus4-asm.cfg
LDFLAGS_VIC20 = -t vic20 -u __EXEHDR__ -C vic20-asm.cfg

DEPDIR := .deps

DISK = anykey.d64
DISK_D81 = anykey.d81
DISK_PET = anykey-pet.d64

DISKS = ${DISK} ${DISK_D81} ${DISK_PET}

PROGRAMS = \
	anykey.prg \
	anykey-64.prg \
	anykey-128.prg \
	anykey-mega65.prg \
	anykey-pet.prg \
	anykey-pet-8k.prg \
	anykey-pet-full.prg \
	anykey-plus4.prg \
	anykey-vic20.prg \
	autoboot-mega65.prg

SOURCES_COMMON = \
	commands.s \
	display-key.s \
	keyboard.s \
	main-loop.s \
	memcpy.s \
	rl-expand.s

SOURCES_VICII_TED = \
	button.s \
	charset.s \
	colors.s \
	copyrect.s \
	display-joystick.s \
	display-key-vicii-ted.s \
	dpad.s \
	irq.s \
	irq-table.s \
	keyboard-vicii-ted.s \
	help-commands.s \
	screen.s \
	state.s

SOURCES_TED = \
	start-ted.s \
	help-ted.s \
	joysticks-ted.s \
	switch-ted.s \
	${SOURCES_VICII_TED}

SOURCES_VICII = \
	start-vicii.s \
	help-vicii.s \
	joysticks-vicii.s \
	keyboard-vicii.s \
	logo.s \
	restore-nmi.s \
	sprite.s \
	sprites.s \
	switch-vicii.s \
	${SOURCES_VICII_TED}

SOURCES_64_128 = \
	${SOURCES_VICII} \
	${SOURCES_COMMON} \
	keyboard-128-charset.s \
	irq-table-128.s \
	keys-128.s \
	screen-128.s

SOURCES_64 = \
	${SOURCES_64_128} \
	help-screens-64.s \
	keyboard-64-charset.s \
	keyboard-mega65-c64-charset.s \
	keys-64.s \
	keys-mega65.s \
	irq-table-64.s \
	irq-table-mega65-c64.s \
	screen-64.s \
	screen-mega65-c64.s

SOURCES_128 = \
	${SOURCES_64_128} \
	help-screens-128.s

SOURCES_MEGA65 = \
	${SOURCES_VICII} \
	${SOURCES_COMMON} \
	help-screens-mega65.s \
	keyboard-mega65-c64-charset.s \
	keys-mega65.s \
	irq-table-mega65-c64.s \
	screen-mega65-c64.s

SOURCES_PET_COMMON = \
	start-pet.s \
	display-key-pet-40c.s \
	expand.s \
	help-keys.s \
	help-screen-pet-40.s \
	pet-help-footer-40.s \
	keyboard-pet-40.s \
	keyboard-pet-calculator-40-left.s \
	keys-pet-calculator-40.s \
	pet-detect.s \
	pet-help.s \
	${SOURCES_COMMON}

SOURCES_PET_8K_PLUS = \
	display-key-pet-40g.s \
	keyboard-pet-graphics-40-left.s \
	keys-pet-graphics-40.s

SOURCES_PET_FULL = \
	${SOURCES_PET_COMMON} \
	${SOURCES_PET_8K_PLUS} \
	display-key-pet-40b.s \
	display-key-pet-80.s \
	help-screen-pet-80.s \
	pet-help-footer-80.s \
	keyboard-pet-80.s \
	keys-pet-business-40.s \
	keyboard-pet-business-40-left.s \
	keys-pet-business-80.s \
	keys-pet-calculator-80.s \
	pet-model.s

SOURCES_PET_8K = \
	${SOURCES_PET_COMMON} \
	${SOURCES_PET_8K_PLUS} \
	pet-model-8k.s

SOURCES_PLUS4 = \
	${SOURCES_TED} \
	${SOURCES_COMMON} \
	help-screens-plus4.s \
	keyboard-plus4-charset.s \
	keys-plus4.s \
	irq-table-plus4.s \
	screen-plus4.s

SOURCES_VIC20 = \
	start-vic20.s \
	${SOURCES_COMMON} \
	display-key-vic20.s \
	irq.s \
	irq-table-vic20.s \
	help-commands.s \
	help-keys.s \
	help-screens-vic20.s \
	keyboard-vic20-charset.s \
	keys-vic20.s \
	platform-vic20.s \
	restore-nmi.s \
	state.s \
	vic20-help-screen.s \
	vic20-main-screen.s


OBJECTS_64 = ${SOURCES_64:%.s=%-64.o}
OBJECTS_128 = ${SOURCES_128:%.s=%-128.o}
OBJECTS_MEGA65 = ${SOURCES_MEGA65:%.s=%-mega65.o}
OBJECTS_PET_8K = ${SOURCES_PET_8K:%.s=%-pet.o}
OBJECTS_PET_FULL = ${SOURCES_PET_FULL:%.s=%-pet.o}
OBJECTS_PLUS4 = ${SOURCES_PLUS4:%.s=%-plus4.o}
OBJECTS_VIC20 = ${SOURCES_VIC20:%.s=%-vic20.o}


ALL_OBJECTS = \
	${OBJECTS_64} \
	${OBJECTS_128} \
	${OBJECTS_MEGA65} \
	${OBJECTS_PET_8K} \
	${OBJECTS_PET_FULL} \
	${OBJECTS_PLUS4} \
	${OBJECTS_VIC20}

PROGRAMS += detect-pet.prg
SOURCES_DETECT_PET = detect-pet-model.s pet-detect.s
OBJECTS_DETECT_PET = ${SOURCES_DETECT_PET:%.s=%-pet.o}
ALL_OBJECTS += ${OBJECTS_DETECT_PET}



all: ${PROGRAMS} ${DISKS}

clean:
	rm -f ${ALL_OBJECTS} ${PROGRAMS}


%-64.o : %.s ${DEPDIR}/%-64.o.d | ${DEPDIR}
	${CC} -o $@ ${CFLAGS_64} --create-dep ${DEPDIR}/$@.d -c $<

%-128.o : %.s ${DEPDIR}/%-128.o.d | ${DEPDIR}
	${CC} -o $@ ${CFLAGS_128} --create-dep ${DEPDIR}/$@.d -c $<

%-mega65.o : %.s ${DEPDIR}/%-mega65.o.d | ${DEPDIR}
	${CC} -o $@ ${CFLAGS_MEGA65} --create-dep ${DEPDIR}/$@.d -c $<

%-pet.o : %.s ${DEPDIR}/%-pet.o.d | ${DEPDIR}
	${CC} -o $@ ${CFLAGS_PET} --create-dep ${DEPDIR}/$@.d -c $<

%-plus4.o : %.s ${DEPDIR}/%-plus4.o.d | ${DEPDIR}
	${CC} -o $@ ${CFLAGS_PLUS4} --create-dep ${DEPDIR}/$@.d -c $<

%-vic20.o : %.s ${DEPDIR}/%-vic20.o.d | ${DEPDIR}
	${CC} -o $@ ${CFLAGS_VIC20} --create-dep ${DEPDIR}/$@.d -c $<

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
	c1541 $$disk -silent -write "anykey-mega65.prg" "anykey mega65"; \
	c1541 $$disk -silent -write "anykey-pet.prg" "anykey pet"; \
	c1541 $$disk -silent -write "anykey-plus4.prg" "anykey plus/4"; \
	c1541 $$disk -silent -write "anykey-vic20.prg" "anykey vic-20"; \
	ips_util apply boot-comma8-d64.ips $$disk -o ${DISK}); \
	rm $$disk

${DISK_D81}: ${PROGRAMS}
	disk=${DISK_D81}.$$$$; \
	(set -e; \
	c1541 -silent -format "anykey,tp" d81 $$disk; \
	c1541 $$disk -silent -write "anykey.prg" "anykey"; \
	c1541 $$disk -silent -write "anykey-64.prg" "anykey 64"; \
	c1541 $$disk -silent -write "anykey-128.prg" "anykey 128"; \
	c1541 $$disk -silent -write "anykey-mega65.prg" "anykey mega65"; \
	c1541 $$disk -silent -write "anykey-pet.prg" "anykey pet"; \
	c1541 $$disk -silent -write "anykey-plus4.prg" "anykey plus/4"; \
	c1541 $$disk -silent -write "anykey-vic20.prg" "anykey vic-20"; \
	c1541 $$disk -silent -write "autoboot-mega65.prg" "autoboot.c65"; \
	ips_util apply boot-comma8-d81.ips $$disk -o ${DISK_D81}); \
	rm $$disk

${DISK_PET}: ${PROGRAMS}
	disk=${DISK_PET}.$$$$; \
	(set -e; \
	c1541 -silent -format "anykey pet,tp" d64 $$disk; \
	c1541 $$disk -silent -write "anykey-pet.prg" "anykey pet"; \
	c1541 $$disk -silent -write "anykey-pet-full.prg" "anykey pet full"; \
	c1541 $$disk -silent -write "anykey-pet-8k.prg" "anykey pet 8k"; \
	ips_util apply comma8-pet.ips $$disk -o ${DISK_PET}); \
	rm $$disk


anykey.prg: anykey.bas
	petcat -w3 -l 0801 -o anykey.prg anykey.bas

anykey-pet.prg: anykey-pet.bas
	petcat -w1p -l 0401 -o anykey-pet.prg anykey-pet.bas

anykey-64.prg: ${OBJECTS_64}
	${LD} ${LDFLAGS_64} -o anykey-64.prg -Ln anykey-64.sym ${OBJECTS_64}

anykey-128.prg: ${OBJECTS_128}
	${LD} ${LDFLAGS_128} -o anykey-128.prg -Ln anykey-128.sym ${OBJECTS_128}

anykey-mega65.prg: ${OBJECTS_MEGA65}
	${LD} ${LDFLAGS_MEGA65} -o anykey-mega65.prg -Ln anykey-mega65.sym ${OBJECTS_MEGA65}

anykey-plus4.prg: ${OBJECTS_PLUS4}
	${LD} ${LDFLAGS_PLUS4} -o anykey-plus4.prg -Ln anykey-plus4.sym ${OBJECTS_PLUS4}

anykey-pet-8k.prg: ${OBJECTS_PET_8K}
	${LD} ${LDFLAGS_PET} -o anykey-pet-8k.prg  -Ln anykey-pet-8k.sym ${OBJECTS_PET_8K}

anykey-pet-full.prg: ${OBJECTS_PET_FULL}
	${LD} ${LDFLAGS_PET} -o anykey-pet-full.prg -Ln anykey-pet-full.sym ${OBJECTS_PET_FULL}

anykey-vic20.prg: ${OBJECTS_VIC20}
	${LD} ${LDFLAGS_VIC20} -o $@ -Ln anykey-vic20.sym ${OBJECTS_VIC20}

autoboot-mega65.prg: autoboot-mega65.bas
	petcat -w65 -l 0801 -o autoboot-mega65.prg autoboot-mega65.bas

help-screens-64.s: help-screens.txt ${CONVERT_SCREENS_DEPENDENCIES}
	${CONVERT_SCREENS} -DVERSION=${VERSION} -D__C64__ -DUSE_VICII $< $@

help-screens-128.s: help-screens.txt ${CONVERT_SCREENS_DEPENDENCIES}
	${CONVERT_SCREENS} -DVERSION=${VERSION} -D__C64__ -DUSE_VICII $< $@

help-screens-mega65.s: help-screens.txt ${CONVERT_SCREENS_DEPENDENCIES}
	${CONVERT_SCREENS} -DVERSION=${VERSION} -D__MEGA65__ $< $@

help-screens-plus4.s: help-screens.txt ${CONVERT_SCREENS_DEPENDENCIES}
	${CONVERT_SCREENS} -DVERSION=${VERSION} -D__PLUS4__ -DUSE_TED $< $@

help-screens-vic20.s: help-screens-vic20.txt ${CONVERT_SCREENS_DEPENDENCIES}
	${CONVERT_SCREENS} -DVERSION=${VERSION} -D__VIC20__ $< $@

keys-64.s: keys-64.key key-table
	./key-table keys-64

keys-128.s: keys-128.key key-table
	./key-table keys-128

keys-mega65.s: keys-mega65.key key-table
	./key-table keys-mega65

keys-pet-business-40.s: keys-pet-business-40.key key-table
	./key-table keys-pet-business-40

keys-pet-business-80.s: keys-pet-business-80.key key-table
	./key-table keys-pet-business-80

keys-pet-calculator-40.s: keys-pet-calculator-40.key key-table
	./key-table keys-pet-calculator-40

keys-pet-calculator-80.s: keys-pet-calculator-80.key key-table
	./key-table keys-pet-calculator-80

keys-pet-graphics-40.s: keys-pet-graphics-40.key key-table
	./key-table keys-pet-graphics-40

keys-plus4.s: keys-plus4.key key-table
	./key-table keys-plus4

keys-vic20.s: keys-vic20.key key-table
	./key-table keys-vic20

keyboard-64-charset.s keyboard-64-screen.bin: keyboard-64.toml keyboard-64-normal-bitmap.bin keyboard-64-pressed-bitmap.bin ${CONVERT_KEYBOARD_DEPENDENCIES}
	${CONVERT_KEYBOARD} $<

keyboard-128-charset.s keyboard-128-screen.bin: keyboard-128.toml keyboard-128-normal-bitmap.bin keyboard-128-pressed-bitmap.bin ${CONVERT_KEYBOARD_DEPENDENCIES}
	${CONVERT_KEYBOARD} $<
	
keyboard-mega65-c64-charset.s keyboard-mega65-c64-screen.bin: keyboard-mega65-c64.toml keyboard-mega65-c64-normal-bitmap.bin keyboard-mega65-c64-pressed-bitmap.bin ${CONVERT_KEYBOARD_DEPENDENCIES}
	${CONVERT_KEYBOARD} $<

keyboard-plus4-charset.s keyboard-plus4-screen.bin: keyboard-plus4.toml keyboard-plus4-normal-bitmap.bin keyboard-plus4-pressed-bitmap.bin ${CONVERT_KEYBOARD_DEPENDENCIES}
	${CONVERT_KEYBOARD} $<

keyboard-vic20-charset.s keyboard-vic20-screen.bin: keyboard-vic20.toml keyboard-vic20-normal-bitmap.bin keyboard-vic20-pressed-bitmap.bin dpad-vic20.bin buttons-vic20.bin ${CONVERT_KEYBOARD_DEPENDENCIES}
	${CONVERT_KEYBOARD} $<

keyboard-64-pressed-bitmap.bin: keyboard-64-pressed.png
	gfx-convert -b 1 bitmap keyboard-64-pressed.png  keyboard-64-pressed

keyboard-64-normal-bitmap.bin: keyboard-64-normal.png
	gfx-convert -b 1 bitmap keyboard-64-normal.png  keyboard-64-normal

keyboard-128-normal-bitmap.bin: keyboard-128-normal.png
	gfx-convert -b 1 bitmap keyboard-128-normal.png keyboard-128-normal

keyboard-128-pressed-bitmap.bin: keyboard-128-pressed.png
	gfx-convert -b 1 bitmap keyboard-128-pressed.png keyboard-128-pressed

keyboard-mega65-c64-normal-bitmap.bin: keyboard-mega65-c64-normal.png
	gfx-convert -b 1 bitmap keyboard-mega65-c64-normal.png keyboard-mega65-c64-normal

keyboard-mega65-c64-pressed-bitmap.bin: keyboard-mega65-c64-pressed.png
	gfx-convert -b 1 bitmap keyboard-mega65-c64-pressed.png keyboard-mega65-c64-pressed

keyboard-plus4-normal-bitmap.bin: keyboard-plus4-normal.png
	gfx-convert -b 1 bitmap keyboard-plus4-normal.png keyboard-plus4-normal

keyboard-plus4-pressed-bitmap.bin: keyboard-plus4-pressed.png
	gfx-convert -b 1 bitmap keyboard-plus4-pressed.png keyboard-plus4-pressed

keyboard-vic20-normal-bitmap.bin: keyboard-vic20-normal.png
	gfx-convert -b 1 bitmap $< keyboard-vic20-normal

keyboard-vic20-pressed-bitmap.bin: keyboard-vic20-pressed.png
	gfx-convert -b 1 bitmap $< keyboard-vic20-pressed


buttons-vic20.bin: buttons-vic20.png
	gfx-convert -b 1 charset $< $@

charset.bin: charset.png
	gfx-convert -b 255 charset $< $@

charset-vic20.bin: charset-vic20.png
	gfx-convert -b 255 charset $< $@

dpad-vic20.bin: dpad-vic20.png
	gfx-convert -b 1 charset $< $@

sprites.bin: sprites.png
	gfx-convert sprites sprites.png sprites.bin

dpad.bin: dpad.png charset.bin
	gfx-convert screen dpad.png charset.bin dpad.bin

keyboard-pet-business-40.bin: keyboard-pet-business-40.scr screen.pl
	perl screen.pl -w 40 -c keyboard-pet-business-40.scr > keyboard-pet-business-40.bin || (rm keyboard-pet-business-40.bin; exit 1)

keyboard-pet-business-80.bin: keyboard-pet-business-80.scr screen.pl
	perl screen.pl -w 80 -c keyboard-pet-business-80.scr > keyboard-pet-business-80.bin || (rm keyboard-pet-business-80.bin; exit 1)

keyboard-pet-calculator-40.bin: keyboard-pet-calculator-40.scr screen.pl
	perl screen.pl -w 40 -c keyboard-pet-calculator-40.scr > keyboard-pet-calculator-40.bin || (rm keyboard-pet-calculator-40.bin; exit 1)

keyboard-pet-calculator-80.bin: keyboard-pet-calculator-80.scr screen.pl
	perl screen.pl -w 80 -c keyboard-pet-calculator-80.scr > keyboard-pet-calculator-80.bin || (rm keyboard-pet-calculator-80.bin; exit 1)

keyboard-pet-graphics-40.bin: keyboard-pet-graphics-40.scr screen.pl
	perl screen.pl -w 40 -c keyboard-pet-graphics-40.scr > keyboard-pet-graphics-40.bin || (rm keyboard-pet-graphics-40.bin; exit 1)

keyboard-pet-business-40-left.s: keyboard-pet-business-40.scr list-left.pl
	perl list-left.pl keyboard-pet-business-40.scr keyboard-pet-business-40-left.s left_business_40

keyboard-pet-calculator-40-left.s: keyboard-pet-calculator-40.scr list-left.pl
	perl list-left.pl keyboard-pet-calculator-40.scr keyboard-pet-calculator-40-left.s left_calculator_40

keyboard-pet-graphics-40-left.s: keyboard-pet-graphics-40.scr list-left.pl
	perl list-left.pl keyboard-pet-graphics-40.scr keyboard-pet-graphics-40-left.s left_graphics_40

help-screen-pet-40.s: help-screen-pet-40.txt ${CONVERT_SCREENS_DEPENDENCIES}
	${CONVERT_SCREENS} -DVERSION=${VERSION} $< $@

help-screen-pet-80.s: help-screen-pet-80.txt ${CONVERT_SCREENS_DEPENDENCIES}
	${CONVERT_SCREENS} -DVERSION=${VERSION} $< $@

pet-help-footer-40.s: pet-help-footer-40.txt ${CONVERT_SCREENS_DEPENDENCIES}
	${CONVERT_SCREENS} $< $@

pet-help-footer-80.s: pet-help-footer-80.txt ${CONVERT_SCREENS_DEPENDENCIES}
	${CONVERT_SCREENS} $< $@

vic20-main-screen.s: vic20-main-screen.txt keyboard-vic20-screen.bin ${CONVERT_SCREENS_DEPENDENCIES}
	${CONVERT_SCREENS} $< $@

vic20-help-screen.s: vic20-help-screen.txt keyboard-vic20-screen.bin ${CONVERT_SCREENS_DEPENDENCIES}
	${CONVERT_SCREENS} $< $@

detect-pet.prg: ${OBJECTS_DETECT_PET}
	${LD} ${LDFLAGS_PET} -o detect-pet.prg ${OBJECTS_DETECT_PET}
