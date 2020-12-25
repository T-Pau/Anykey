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

.include "defines.inc"

.macpack cbm
.macpack cbm_ext
.macpack utility
.macpack c128

.rodata
help_screen:
	invcode "                                        "
	scrcode "I                                      J"
	.repeat 18, i
	scrcode "                                        "
	.endrep
	scrcode "KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMML"
	invcode "                                        "
.if .defined(USE_VICII)
	invcode "  space/+: next page  -: previous page  "
	invcode "         "
	.byte $9f
	invcode           ": return to program           "
	invcode "                                        "
.elseif .defined(USE_TED)
	invcode "  space/+: next  -: previous            "
	invcode "    esc: return to program       "
	.byte $79, $7a, $7b, $7c, $7d, $7e, $7f
	invcode "                                 "
	.byte $f9, $fa, $fb, $fc, $fd, $fe, $ff
.endif

help_color:
	.res 2 * 40, FRAME_COLOR
	.res 18 * 40, CONTENT_COLOR
	.res 5 * 40, FRAME_COLOR

.code

display_main_screen:
.ifdef USE_VICII
	memcpy_128 screen, main_screen_64, main_screen_128, 1000
	memcpy color_ram, main_color_save, 1000
.ifdef __C64__
	lda is_128
	beq c64
.endif
	ldx #<main_128_irq_table
	ldy #>main_128_irq_table
	lda main_128_irq_table_length
.ifdef __C64__
	bne both
c64:
	ldx #<main_64_irq_table
	ldy #>main_64_irq_table
	lda main_64_irq_table_length
both:
.endif
.else
	memcpy screen, main_screen_plus4, 1000
	memcpy color_ram, main_color_save, 1000
	ldx #<main_plus4_irq_table
	ldy #>main_plus4_irq_table
	lda main_plus4_irq_table_length
.endif
	jsr set_irq_table
	rts

display_help_screen:
	ldx #<help_irq_table
	ldy #>help_irq_table
	lda help_irq_table_length
	jsr set_irq_table

.ifdef USE_VICII
	lda #0
	ldy #7
:	sta VIC_SPR0_X,y
	dey
	bpl :-
	lda VIC_SPR_HI_X
	and #$f0
	sta VIC_SPR_HI_X
.endif

	memcpy main_color_save, color_ram, 1000
	memcpy screen, help_screen, 1000
	memcpy color_ram, help_color, 1000
	ldx #0
	stx current_help_page
	jsr display_help_page
	rts
