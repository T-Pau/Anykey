;  pet-model.s -- Set up model specific data.
;  Copyright (C) 2022 Dieter Baron
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

.include "defines.inc"
.include "pet-detect.inc"

.autoimport +

.export setup_model, reset_keyboard, saved_screen, saved_screen_size, help_keys, help_count, help_pages, help_footer, left_list

.macpack utility

.ifdef FIT_IN_8K
saved_screen_size = saved_screen_size_table
keyboard_pet_business_40_screen = 0
keys_pet_business_40_address_low = 0
left_business_40 = 0
.endif

SAVED_SCREEN_SIZE_40 = (40 * 22)
SAVED_SCREEN_SIZE_80 = (80 * 22)

.ifdef FIT_IN_8K
MAX_SAVED_SCREEN_SIZE = SAVED_SCREEN_SIZE_40
.else
MAX_SAVED_SCREEN_SIZE = SAVED_SCREEN_SIZE_80
.endif

.code

setup_model:
.scope
    jsr detect
    lda line_width
.ifdef FIT_IN_8K
    beq line_width_supported
.else
    bpl line_width_supported
.endif
not_supported:
    lda #$ff
    rts
line_width_supported:
    asl
    tax
.ifndef FIT_IN_8K
    lda reset_keyboard_routine_table,x
    sta reset_keyboard_routine
    lda reset_keyboard_routine_table + 1,x
    sta reset_keyboard_routine + 1
    lda saved_screen_size_table,x
    sta saved_screen_size
    lda saved_screen_size_table + 1,x
    sta saved_screen_size + 1
.endif
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
    sta help_count
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
.ifdef FIT_IN_8K
    beq not_supported
.endif
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
.ifndef FIT_IN_8K
    asl
    ora line_width
.endif
    asl
    sta keyboard_type_index
    tax
    lda keyboard_screen_table,x
    sta ptr1
    lda keyboard_screen_table + 1,x
    sta ptr1 + 1
    lda #<screen
    sta ptr2
    lda #>screen
    sta ptr2 + 1
    jsr expand

    ldx keyboard_type_index
    lda keyboard_table,x
    ldy keyboard_table + 1,x
    tax
    lda #80
    jsr set_keys_table
    lda #0
    rts
.endscope

reset_keyboard:
.ifdef FIT_IN_8K
    jmp reset_keyboard_40
.else
    jmp (reset_keyboard_routine)
.endif

.rodata

; indexed by line_width
.ifndef FIT_IN_8K
reset_keyboard_routine_table:
    .word reset_keyboard_40
    .word reset_keyboard_80
.endif

saved_screen_size_table:
    .word SAVED_SCREEN_SIZE_40
.ifndef FIT_IN_8K
    .word SAVED_SCREEN_SIZE_80
.endif

; indexed by line_width
help_table:
    .word help_40
.ifndef FIT_IN_8K
    .word help_80
.endif

help_40:
    .word num_help_40_screens
    .word help_40_screens
    .word help_40_footer

.ifndef FIT_IN_8K
help_80:
    .word num_help_80_screens
    .word help_80_screens
    .word help_80_footer
.endif

; indexed by keyboard type != business
key_index_help_table:
    .byte $27, $0f

; indexed by keyboard type != business
key_index_reset_table:
    .byte $44, $06

; indexed by keyboard type != business
help_keys_table:
    .word help_keys_business
    .word help_keys_graphics

; indexed by keyboard type
left_list_table:
    .word left_business_40
    .word left_calculator_40
    .word left_graphics_40

; indexed by keyboard type (* 2 + line_width)
keyboard_screen_table:
    .word keyboard_pet_business_40_screen
.ifndef FIT_IN_8K
    .word keyboard_pet_business_80_screen
.endif
    .word keyboard_pet_calculator_40_screen
.ifndef FIT_IN_8K
    .word keyboard_pet_calculator_80_screen
.endif
    .word keyboard_pet_graphics_40_screen

; indexed by keyboard type (* 2 + line_width)
keyboard_table:
    .word keys_pet_business_40_address_low
.ifndef FIT_IN_8K
    .word keys_pet_business_80_address_low
.endif
    .word keys_pet_calculator_40_address_low
.ifndef FIT_IN_8K
    .word keys_pet_calculator_80_address_low
.endif
    .word keys_pet_graphics_40_address_low


help_keys_graphics:
    .byte $4a, COMMAND_HELP_NEXT ; space
    .byte $3f, COMMAND_HELP_NEXT ; +
    .byte $47, COMMAND_HELP_PREVIOUS; -
    .byte $06, COMMAND_HELP_EXIT ; clr/home
    .byte $ff

.ifndef FIT_IN_4K
help_keys_business:
    .byte $42, COMMAND_HELP_NEXT ; space
    .byte $16, COMMAND_HELP_NEXT ; + (actually ;)
    .byte $03, COMMAND_HELP_PREVIOUS ; -
    .byte $44, COMMAND_HELP_EXIT ; clr/home
    .byte $10, COMMAND_HELP_EXIT ; escape
    .byte $ff
.endif


.bss

help_count:
    .res 1

help_pages:
    .res 2

help_footer:
    .res 2

help_keys:
    .res 2

.ifndef FIT_IN_8K
reset_keyboard_routine:
    .res 2

saved_screen_size:
    .res 2
.endif

left_list:
    .res 2

saved_screen:
    .res MAX_SAVED_SCREEN_SIZE

keyboard_type_index:
    .res 1
