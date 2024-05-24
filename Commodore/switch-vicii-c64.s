;  switch-vicii-c64.s -- C64 specific IRQ handler routines for VIC-II.
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
;  THIS SOFTWARE IS PROVIDED BY THE AUTHORS "AS IS" AND ANY EXPRESS
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

.public switch_keyboard_top_acellerated {
    jsr content_background
    lda #FRAME_COLOR
    ldx #SCREEN_TOP + 8 + 1
:	cpx VIC_RASTER
    bne :-
    set_vic_text screen, charset_keyboard_top
    ldx #0
    jsr read_pots
    rts
}


.public switch_keyboard_bottom_acellerated {
    lda #VIC_VIDEO_ADDRESS(screen, charset_keyboard_bottom)
    ldx bottom_charset_line
    inx
:	cpx VIDEO_CURRENT_LINE
    bne :-
    sta VIC_VIDEO_ADDRESS
    lda command
    bne :+
    jsr handle_joysticks
:
    jmp select_pots2
}