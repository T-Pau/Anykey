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
