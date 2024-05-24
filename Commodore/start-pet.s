;  start-pet.s -- Entry point of program, PET version.
;  Copyright (C) Dieter Baron
;
;  This file is part of Anykey, a keyboard test program.
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

.pre_if .defined(ONLY_40_COLUMNS)
MAX_SAVED_SCREEN_SIZE = (40 * 22)
.pre_else
MAX_SAVED_SCREEN_SIZE = (80 * 22)
.pre_end

.public start {
    lda #142
    jsr CHROUT
;	lda #12
;	sta VIA_PCR

    jsr setup_model
    bpl :+
    jmp not_supported

:	ldx #0
    stx command
    stx last_command
    dex
    stx current_page
    jsr init_keyboard
    jmp main_loop
}


.public process_keyboard {
:   lda $8d + 2 ; TOD in ROM 2 & 4
    ora $0202   ; TOD in ROM 1
    cmp last_tick
    beq :-
    sta last_tick
    jsr read_keyboard
    lda current_page
    cmp #$ff
    bne help_mode
    jsr display_keyboard
    jmp process_command_keys
help_mode:
    jmp handle_help_keys
}


compare_matrix {
    stx ptr1
    sty ptr1 + 1
    ldy #$f
loop:
    lda $e6d1,y
    cmp (ptr1),y
    beq :+
    rts
:   dey
    bpl loop
    cpy #$ff
    rts
}


not_supported {
    lda line_width
    bne msg_80
    store_word not_supported_message_40, ptr1
    bne print
msg_80:
    store_word not_supported_message_80, ptr1
print:
    ldy #0
loop:
    lda (ptr1),y
    bne :+
    rts
:   jsr CHROUT
    iny
    bne loop
}


.section data

not_supported_message_40 {
    .data "this model is not supported by this", $0d
    .data "version of anykey.", $0d, $0
}


not_supported_message_80 {
    .data "this model is not supported by this version of anykey.", $0d, $0
}

.section reserved

last_tick .reserve 1
