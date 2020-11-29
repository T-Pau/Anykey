.autoimport +
.export display_logo, setup_logo

;  logo.s -- Display T'Pau logo.
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


.macpack cbm_ext
.include "anykey.inc"

LOGO_X = 32 + 40 * 8 - (15 + 36) - 8
LOGO_Y = 50 + 25 * 8

.rodata

stripe_colors:
	.byte COLOR_RED, COLOR_ORANGE, COLOR_YELLOW, COLOR_GREEN, COLOR_BLUE

.code

display_logo:
	set_vic_24_lines
	lda #COLOR_GRAY2
	sta VIC_BG_COLOR0
	
	ldy #LOGO_Y + 2
	ldx #0
loop:
	lda stripe_colors,x	
:	cpy VIC_HLINE
	bne :-
	sta VIC_SPR4_COLOR
	iny
	iny
	inx
	cpx #5
	bne loop
	
	set_vic_25_lines
	
	rts

setup_logo:
	lda #00
	sta $7fff
	lda #<LOGO_X
	sta VIC_SPR4_X
	sta VIC_SPR5_X
	clc
	adc #17
	sta VIC_SPR6_X
	adc #24
	sta VIC_SPR7_X
	lda VIC_SPR_HI_X
	ora #$f0
	sta VIC_SPR_HI_X
	lda #LOGO_Y
	sta VIC_SPR4_Y
	sta VIC_SPR5_Y
	sta VIC_SPR6_Y
	sta VIC_SPR7_Y
	lda #COLOR_BLACK
	sta VIC_SPR5_COLOR
	lda #COLOR_GRAY1
	sta VIC_SPR6_COLOR
	sta VIC_SPR7_COLOR
	ldx #sprite_logo
	stx screen + $3fc
	inx
	stx screen + $3fd
	inx
	stx screen + $3fe
	inx
	stx screen + $3ff
	lda VIC_SPR_ENA
	ora #$f0
	sta VIC_SPR_ENA
	rts
