;  pet-model.s -- Set up model specific data for 4k machines.
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

.export setup_model, saved_screen, saved_screen_size, help_keys, help_count, help_pages

.macpack utility

SAVED_SCREEN_SIZE_40 = (40 * 22)

.code

setup_model:
.scope
    jsr detect
    lda line_width
    beq :+
not_supported:
    lda #$ff
    rts
:   ldx keyboard_type
    cpx #1
    bne not_supported
    lda help_40_count
    sta help_count
    lda #$0f
    sta key_index_help
    lda #$06
    sta key_index_reset
    copy_screen keyboard_pet_calculator_40_screen
    ldx #<keys_pet_calculator_40_address_low
    ldy #>keys_pet_calculator_40_address_low
    lda #80
    jsr set_keys_table

    lda #0
    rts
.endscope

.rodata

help_keys_graphics:
    .byte $4a, COMMAND_HELP_NEXT ; space
    .byte $3f, COMMAND_HELP_NEXT ; +
    .byte $47, COMMAND_HELP_PREVIOUS; -
    .byte $06, COMMAND_HELP_EXIT ; clr/home
    .byte $ff

saved_screen_size:
    .res SAVED_SCREEN_SIZE_40

help_pages:
    .word help_40_pages

help_keys:
    .word help_keys_graphics

.bss

help_count:
    .res 1

saved_screen:
    .res SAVED_SCREEN_SIZE_40
