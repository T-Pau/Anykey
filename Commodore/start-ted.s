;  start.s -- Entry point of program.
;  Copyright (C) Dieter Baron
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

.section code

.global start {
	jsr init_state

	memcpy charset, charset_data, $800
	memcpy charset_keyboard_top, keyboard_plus4_charset_top, $0400
	memcpy charset_keyboard_top + $400, keyboard_plus4_charset_top_inv, $0400
	memcpy charset_keyboard_bottom, keyboard_plus4_charset_bottom, $0400
	memcpy charset_keyboard_bottom + $400, keyboard_plus4_charset_bottom_inv, $0400

	lda TED_MULTI1
	ora #$80
	sta TED_MULTI1
	lda TED_BITMAP
	and #$04 ^ $ff
	sta TED_BITMAP
	
	jsr display_main_screen
	lda #FRAME_COLOR
	sta VIDEO_BORDER_COLOR

	jsr init_irq
	
	jmp main_loop
}
