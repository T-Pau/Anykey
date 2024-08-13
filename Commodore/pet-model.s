;  pet-model.s -- Set up model specific data.
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

.pre_if .defined(FIT_IN_8K)
.public saved_screen_size = saved_screen_size_table
.pre_end

SAVED_SCREEN_SIZE_40 = (40 * 22)
SAVED_SCREEN_SIZE_80 = (80 * 22)

.section code

.public setup_model {
    jsr detect
    lda line_width
    .if .defined(FIT_IN_8K) {
        beq line_width_supported
    }
    .else {
        bpl line_width_supported
    }
not_supported:
    lda #$ff
    rts
line_width_supported:
    asl
    tax
    .if !.defined(FIT_IN_8K) {
        lda reset_keyboard_routine_table,x
        sta reset_keyboard_routine
        lda reset_keyboard_routine_table + 1,x
        sta reset_keyboard_routine + 1
        lda saved_screen_size_table,x
        sta saved_screen_size
        lda saved_screen_size_table + 1,x
        sta saved_screen_size + 1
    }
    lda help_table,x
    sta ptr1
    lda help_table + 1,x
    sta ptr1 + 1
    ldy #0
    lda (ptr1),y
    iny
    sta ptr2
    lda (ptr1),y
    sta ptr2 + 1
    ldy #0
    lda (ptr2),y
    sta help_num_pages
    ldy #2
    lda (ptr1),y
    iny
    sta help_pages
    lda (ptr1),y
    iny
    sta help_pages + 1
    lda (ptr1),y
    iny
    sta help_footer
    lda (ptr1),y
    sta help_footer + 1

    ldx keyboard_type
    .if .defined(FIT_IN_8K) {
        beq not_supported
    }
    bmi not_supported
    cpx #2
    bne :+
    dex
:   lda key_index_help_table,x
    sta key_index_help
    lda key_index_reset_table,x
    sta key_index_reset
    txa
    asl
    tax
    lda help_keys_table,x
    sta help_keys
    lda help_keys_table + 1,x
    sta help_keys + 1

    lda keyboard_type
    asl
    tax
    lda left_list_table,x
    sta left_list
    lda left_list_table + 1,x
    sta left_list + 1

    lda keyboard_type
    .if !.defined(FIT_IN_8K) {
        asl
        ora line_width
    }
    asl
    sta keyboard_type_index
    tax
    lda keyboard_screen_table,x
    sta source_ptr
    lda keyboard_screen_table + 1,x
    sta source_ptr + 1
    store_word destination_ptr, screen
    jsr rl_expand

    ldx keyboard_type_index
    lda keyboard_table,x
    ldy keyboard_table + 1,x
    tax
    jsr set_keys_table
    lda #0
    rts
}


.public reset_keyboard {
    .if .defined(FIT_IN_8K) {
        jmp reset_keyboard_40
    }
    .else {
        jmp (reset_keyboard_routine)
    }
}

.section data

; indexed by line_width
.pre_if !.defined(FIT_IN_8K)
reset_keyboard_routine_table {
    .data reset_keyboard_40
    .data reset_keyboard_80
}
.pre_end


saved_screen_size_table {
    .data SAVED_SCREEN_SIZE_40
    .if !.defined(FIT_IN_8K) {
        .data SAVED_SCREEN_SIZE_80
    }
}


; indexed by line_width
help_table {
    .data help_40
    .if !.defined(FIT_IN_8K) {
        .data help_80
    }
}


help_40 {
    .data help_40_screens_count
    .data help_40_screens
    .data help_40_footer
}


.pre_if !.defined(FIT_IN_8K)
help_80 {
    .data help_80_screens_count
    .data help_80_screens
    .data help_80_footer
}
.pre_end


; indexed by keyboard type != business
key_index_help_table {
    .data $27, $0f
}


; indexed by keyboard type != business
key_index_reset_table {
    .data $44, $06
}


; indexed by keyboard type != business
help_keys_table {
    .data help_keys_business
    .data help_keys_graphics
}


; indexed by keyboard type
left_list_table {
    .if .defined(FIT_IN_8K) {
        .data 0:2
    }
    .else {
        .data left_business_40
    }
    .data left_calculator_40
    .data left_graphics_40
}


; indexed by keyboard type (* 2 + line_width)
keyboard_screen_table {
    .if .defined(FIT_IN_8K) {
        .data 0:2
    }
    .else {
        .data keyboard_pet_business_40_screen
        .data keyboard_pet_business_80_screen
    }
    .data keyboard_pet_calculator_40_screen
    .if !.defined(FIT_IN_8K) {
        .data keyboard_pet_calculator_80_screen
    }
    .data keyboard_pet_graphics_40_screen
}


; indexed by keyboard type (* 2 + line_width)
keyboard_table {
    .if .defined(FIT_IN_8K) {
        .data 0:2
    }
    .else {
        .data keys_pet_business_40
        .data keys_pet_business_80
    }
    .data keys_pet_calculator_40
    .if !.defined(FIT_IN_8K) {
        .data keys_pet_calculator_80
    }
    .data keys_pet_graphics_40
}


help_keys_graphics {
    .data $4a, COMMAND_HELP_NEXT ; space
    .data $3f, COMMAND_HELP_NEXT ; +
    .data $47, COMMAND_HELP_PREVIOUS; -
    .data $06, COMMAND_HELP_EXIT ; clr/home
    .data $ff
}


.pre_if !.defined(FIT_IN_4K)
help_keys_business {
    .data $42, COMMAND_HELP_NEXT ; space
    .data $16, COMMAND_HELP_NEXT ; + (actually ;)
    .data $03, COMMAND_HELP_PREVIOUS ; -
    .data $44, COMMAND_HELP_EXIT ; clr/home
    .data $10, COMMAND_HELP_EXIT ; escape
    .data $ff
}
.pre_end


.section reserved

.public help_num_pages .reserve 1
.public help_pages .reserve 2
.public help_footer .reserve 2
.public help_keys .reserve 2

.pre_if !.defined(FIT_IN_8K)
reset_keyboard_routine .reserve 2
.public saved_screen_size .reserve 2
.pre_end

.public left_list .reserve 2
.public saved_screen .reserve MAX_SAVED_SCREEN_SIZE
keyboard_type_index .reserve 1
