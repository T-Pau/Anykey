;  screen.s -- Screen contents.
;  Copyright (C) 2020 Dieter Baron
;
;  This file is part of Anykey, a keyboard test program for C64.
;  The authors can be contacted at <anykey@tpau.group>.
;
;  Redistribution and use in source and binary forms, with or without
;  modification, are permitted provided that the following conditions
;  are met:
;  1. Redistributions of source code must retain the above copyright
;     notice, this list of conditions and the following disclaimer.
;  2. The names of the authors may not be used to endorse or promote
;     products derived from this software without specific prior
;     written permission.
;
;  THIS SOFTWARE IS PROVIDED BY THE AUTHORS ``AS IS'' AND ANY EXPRESS
;  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;  ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY
;  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
;  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
;  IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
;  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
;  IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

.export display_main_screen, display_help_screen

.autoimport +

.include "anykey.inc"

.macpack cbm
.macpack cbm_ext
.macpack utility

.rodata

main_screen:
	invcode " keyboard                               "
	.incbin "keyboard-screen.bin"
	invcode "                                        "
	invcode "        joysticks                       "
	invcode "       "
	scrcode        "I                        J"
	invcode                                  "       "
	invcode "       "
	scrcode        "                          "
	invcode                                  "       "
	invcode "       "
	scrcode        "        AHB          AHB  "
	invcode                                  "       "
	invcode "       "
	scrcode        "        EfF          EfF  "
	invcode                                  "       "
	invcode "       "
	scrcode        "        CGD          CGD  "
	invcode                                  "       "
	invcode "       "
	scrcode        "                          "
	invcode                                  "       "
	invcode "       "
	scrcode        "KMMMMMMMMMMMMMMMMMMMMMMMML"
	invcode                                  "       "
	invcode "                                        "
	invcode "               f8: help                 "
	invcode "                                        "

help_screen:
	invcode "                                        "
	scrcode "I                                      J"
	.repeat 18, i
	scrcode "                                        "
	.endrep
	scrcode "KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMML"
	invcode "                                        "
	invcode "  space/+: next page  -: previous page  "
	invcode "         "
	.byte $9f
	invcode           ": return to program           "
	invcode "                                        "

.code

display_main_screen:
	memcpy screen, main_screen, 1000
	memcpy color_ram, main_color, 1000
	ldx #<main_irq_table
	ldy #>main_irq_table
	lda main_irq_table_length
	jsr set_irq_table
	rts

display_help_screen:
	ldx #<help_irq_table
	ldy #>help_irq_table
	lda help_irq_table_length
	jsr set_irq_table

	lda #0
	ldy #7
:	sta VIC_SPR0_X,y
	dey
	bpl :-
	lda VIC_SPR_HI_X
	and #$f0
	sta VIC_SPR_HI_X

	memcpy screen, help_screen, 1000
	memcpy color_ram, help_color, 1000
	ldx #0
	stx current_help_page
	jsr display_help_page
	rts
