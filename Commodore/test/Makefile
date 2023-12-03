all: test.prg

test.prg: test.s
	cl65 -t mega65 -u __EXEHDR__ -C ../mega65-asm.cfg -o test.prg test.s
