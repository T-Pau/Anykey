.include "defines.inc"
.include "pet-detect.inc"

.autoimport +

.export setup_model, saved_screen, saved_screen_size, help_keys, help_count, help_pages

.export help_table ; DEBUG

.macpack utility

.ifdef FIT_IN_4K
FIT_IN_8K = 1
.endif

.ifdef FIT_IN_8K
help_80_count = 0
.endif
.ifdef FIT_IN_4K
keyboard_pet_business_40_screen = 0
keyboard_pet_graphics_40_screen = 0
keys_pet_business_40_address_low = 0
keys_pet_graphics_40_address_low = 0
help_keys_business = 0
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
    beq :+
.else
    bpl :+
.endif
not_supported:
    lda #$ff
    rts
:   asl
    tax
    lda saved_screen_size_table,x
    sta saved_screen_size
    lda saved_screen_size_table + 1,x
    sta saved_screen_size + 1
    lda help_table,x
    sta ptr1
    lda help_table + 1,x
    sta ptr1 + 1
    ldy #0
    lda (ptr1),y
    sta help_count
    inc_16 ptr1
    lda ptr1
    sta help_pages
    lda ptr1 + 1
    sta help_pages + 1
    ldx keyboard_type
.ifdef FIT_IN_4K
    cpx #1
    bne not_supported
.else
    bmi not_supported
    cpx #2
    bne :+
    dex
:
.endif
    lda key_index_help_table,x
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

.rodata

; indexed by line_width
saved_screen_size_table:
    .word SAVED_SCREEN_SIZE_40
    .word SAVED_SCREEN_SIZE_80

; indexed by line_width
help_table:
    .word help_40_count
    .word help_80_count

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

saved_screen_size:
    .res 2

help_count:
    .res 1

help_pages:
    .res 2

help_keys:
    .res 2

saved_screen:
    .res MAX_SAVED_SCREEN_SIZE


keyboard_type_index:
    .res 1
