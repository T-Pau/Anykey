;  start-pet.s -- Entry point of program, PET version.
;  Copyright (C) 2022 Dieter Baron
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

.export start, process_keyboard

.export display_help_screen, help_next, help_previous, display_main_screen

.macpack utility

SAVED_SCREEN_SIZE = (80 * 22)

.include "defines.inc"

start:
.scope
    ; TODO: doesn't work on 2001
    ; lda LNMX
    ; cmp #39
    ; bne :+
    ; jmp not_80_columns
:	lda #142
	jsr CHROUT
;	lda #12
;	sta VIA_PCR

    ldx #<matrix_graphics
    ldy #>matrix_graphics
    jsr compare_matrix
    bne business_keyboard
	copy_screen keyboard_pet_graphics_screen
	lda #$0f
	sta key_index_help
	lda #$06
	sta key_index_reset
	store_word help_keys_graphics, help_keys
	ldx #<keys_pet_graphics_address_low
	ldy #>keys_pet_graphics_address_low
	lda keys_pet_graphics_num_keys
    bne set_keyboard
business_keyboard:
	copy_screen keyboard_pet_business_screen
	lda #$27
	sta key_index_help
	lda #$44
	sta key_index_reset
	store_word help_keys_business, help_keys
	ldx #<keys_pet_business_address_low
	ldy #>keys_pet_business_address_low
	lda keys_pet_business_num_keys
set_keyboard:
	jsr set_keys_table

	ldx #0
	stx command
	stx last_command
	dex
	stx current_page
	jsr init_keyboard
	jmp main_loop
.endscope

process_keyboard:
.scope
:   lda $8d + 2
    cmp last_tick
    beq :-
    sta last_tick
	jsr read_keyboard
	lda current_page
	cmp #$ff
	bne help_mode
	jmp display_keyboard
help_mode:
    jmp handle_help
.endscope

display_help_screen:
    memcpy saved_screen, screen, SAVED_SCREEN_SIZE
    ldx #0
    beq update_help_page

help_next:
    ldx current_page
    inx
    cpx help_screen_count
    bne update_help_page
    ldx #0
    beq update_help_page

help_previous:
    ldx current_page
    dex
    bpl update_help_page
    ldx help_screen_count
    dex
    bne update_help_page

update_help_page:
    stx current_page
    lda help_screen_address_low,x
    sta ptr1
    lda help_screen_address_high,x
    sta ptr1 + 1
	store_word screen, ptr2
	jmp expand

display_main_screen:
    memcpy screen, saved_screen, SAVED_SCREEN_SIZE
    ldx #$ff
    stx current_page
	rts

handle_help:
.scope
    ldx help_keys
    stx ptr1
    ldx help_keys + 1
    stx ptr1 + 1
    ldy #0
loop:
    lda (ptr1),y
    cmp #$ff
    bne :+
   	lda #0
   	sta last_command
    rts
:   tax
    iny
    lda new_key_state,x
    beq :+
    lda (ptr1),y
    bne got_key
:   iny
    bne loop
got_key:
	cmp last_command
	beq end
	sta last_command
	sta command
end:
    rts
.endscope

compare_matrix:
.scope
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
.endscope

not_80_columns:
.scope
    ldx #0
loop:
    lda not_80_columns_message,x
    bne :+
    rts
:   jsr CHROUT
    inx
    bne loop
.endscope

.rodata

matrix_business:
    .byte $16, $04, $3a, $03, $39, $36, $33, $df
    .byte $b1, $2f, $15, $13, $4d, $20, $58, $12

matrix_graphics:
    .byte $3d, $2e, $10, $03, $3c, $20, $5b, $12
    .byte $2d, $30, $00, $3e, $ff, $5d, $40, $00

not_80_columns_message:
    .byte "anykey requires an 80 column display.", $0d, $00

help_keys_graphics:
    .byte $4b, COMMAND_HELP_NEXT ; space
    .byte $3f, COMMAND_HELP_NEXT ; +
    .byte $47, COMMAND_HELP_PREVIOUS; -
    .byte $07, COMMAND_HELP_EXIT ; clr/home
    .byte $ff

help_keys_business:
    .byte $42, COMMAND_HELP_NEXT ; space
    .byte $16, COMMAND_HELP_NEXT ; + (actually ;)
    .byte $03, COMMAND_HELP_PREVIOUS ; -
    .byte $44, COMMAND_HELP_EXIT ; clr/home
    .byte $10, COMMAND_HELP_EXIT ; escape
    .byte $ff

.bss

current_page:  ; $ff when not in help mode
    .res 1

saved_screen:
    .res SAVED_SCREEN_SIZE

last_tick:
    .res 1

help_keys:
    .res 2
