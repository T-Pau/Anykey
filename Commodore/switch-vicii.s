;  switch-vicii.s -- IRQ handler routines for VIC-II.
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

.public switch_keyboard_top {
    jsr content_background
    lda #FRAME_COLOR
    ldy machine_type
    dey
    bne :+
    lda #BACKGROUND_COLOR
:
    ldx #SCREEN_TOP + 8
:	cpx VIDEO_CURRENT_LINE
    bne :-
    ldx #9
:	dex
    bpl :-
    nop
    nop
    sta VIDEO_BORDER_COLOR
    set_vic_text screen, charset_keyboard_top
    ldx #0
    jsr read_pots
    ldx machine_type
    dex
    bne :+
    jsr read_keyboard
:	rts
}


.public switch_keyboard_bottom {
    lda #VIC_ADDRESS(screen, charset_keyboard_bottom)
    ldx bottom_charset_line
:	cpx VIDEO_CURRENT_LINE
    bne :-
    ldx #9
:	dex
    bpl :-
    nop
    nop
    .if .defined(MEGA65) {
        store_word charset_keyboard_bottom, VIC_CHARSET_POINTER
    }
    .else {
        sta VIC_ADDRESS
    }
    lda command
    bne :+
    jsr handle_joysticks
:
    jmp select_pots2
}



.public switch_joystick_label {
    set_vic_text screen, charset
    lda #FRAME_COLOR
    ldx joystick_label_line
:	cpx VIDEO_CURRENT_LINE
    bne :-
    sta VIDEO_BORDER_COLOR
    jsr label_background
    rts
}


.public switch_joystick {
    jsr content_background
    ldx #1
    jsr read_pots
    ldy machine_type
    dey
    bne not_128
    jsr read_keyboard_128
    jmp both
not_128:
    jsr read_keyboard
both:
    jsr select_pots1
    jsr process_skip
    rts
}


.public switch_joystick_bottom { ; 128 only
    lda #FRAME_COLOR
    ldx #SCREEN_TOP + 22 * 8 - 0
:	cpx VIDEO_CURRENT_LINE
    bne :-
    sta VIDEO_BACKGROUND_COLOR
    lda #LABEL_COLOR
    inx
:	cpx VIDEO_CURRENT_LINE
    bne :-
    sta VIDEO_BACKGROUND_COLOR
    rts
}


.public switch_bottom {
    jsr display_logo
    lda command
    bne :+

    jsr display_keyboard
    jsr process_command_keys
:
    rts
}


.pre_if .defined(C64) || .defined(MEGA65)
.public switch_keyboard_top_mega65 {
    jsr content_background
    lda #FRAME_COLOR
    ldx #SCREEN_TOP + 8 + 5
:	cpx VIDEO_CURRENT_LINE
    bne :-
    set_vic_text screen, charset_keyboard_top
    ldx #0
    jsr read_pots
    jsr read_keyboard_mega65
    rts
}

.public switch_bottom_mega65 {
    lda #2
   	sta VIC_BOTTOM_BORDER_POSITION + 1
   	lda #30
   	sta VIC_BOTTOM_BORDER_POSITION
   	jmp switch_bottom
}
.pre_end
