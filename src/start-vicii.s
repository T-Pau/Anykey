;  start.s -- Entry point of program.
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


.autoimport +

.export start

.include "defines.inc"

.macpack cbm_ext
.macpack utility
.macpack c128

.code

start:
	lda #FRAME_COLOR
	sta VIDEO_BORDER_COLOR

.ifdef __C128__
	lda MMU_CR
	ora #$0e
	sta MMU_CR
.endif

	jsr init_state

	memcpy charset, charset_data, $800
	memcpy_128 charset_keyboard_top, charset_data_64, charset_data_128, $1000
	memcpy sprites, sprite_data, (64 * 8)

	jsr display_main_screen

	set_vic_bank $8000
	set_vic_text screen, charset

	lda #$0f
	sta VIC_SPR_ENA
	lda #0
	sta VIC_SPR_BG_PRIO
	sta VIC_SPR_EXP_X
	sta VIC_SPR_EXP_Y
	sta VIC_SPR_MCOLOR

	jsr setup_logo

	lda #$ff
	sta CIA1_DDRA
	sta CIA1_DDRB

	jsr init_irq
	
	jmp main_loop
