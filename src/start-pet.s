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
; TODO: dummy stubs for now
.export display_help_screen, help_next, help_previous, display_main_screen

.macpack utility

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
	ldx #<keys_pet_graphics_address_low
	ldy #>keys_pet_graphics_address_low
	lda keys_pet_graphics_num_keys
    bne set_keyboard
business_keyboard:
    ; TODO: compare with business_matrix, extended or exit if not?
	copy_screen keyboard_pet_business_screen
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
	jsr read_keyboard
	jsr display_keyboard
	rts

; TODO: dummy stubs for now

display_help_screen:
    memcpy saved_screen, screen, 80*25
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
    memcpy screen, saved_screen, 80*22
    ldx #$ff
    stx current_page
	rts

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

.bss

current_page:  ; $ff when not in help mode
    .res 1

saved_screen:
    .res 80*22
