.autoimport +
.macpack utility
.include "platform.inc"

.export charset

.export display_help_screen, display_main_screen, reset_keyboard


.segment "CODE_LOW"

display_help_screen:
    rts

display_main_screen:
    store_word main_screen, ptr1
    store_word screen, ptr2
    jsr rl_expand
    store_word main_color, ptr1
    store_word color_ram, ptr2
    jsr rl_expand
    ldx #<main_vic20_irq_table
    ldy #>main_vic20_irq_table
    lda main_vic20_irq_table_length
    jsr set_irq_table
    rts

.export top_keyboard
top_keyboard:
    lda #$cd
    sta $9005
    rts

.export bottom_keyboard
bottom_keyboard:
    lda #$cf
    sta $9005
    rts

reset_keyboard:
    rts


.segment "CHARSET"

charset:
	.incbin "charset-vic20.bin"

.rodata

main_color:
    .byte $ff, 22, FRAME_COLOR
    .byte $ff, 255, UNCHECKED_COLOR
    .byte $ff, 12 * 22 - 255, UNCHECKED_COLOR
    .byte $ff, 22 * 2, FRAME_COLOR
    .byte $ff, 22 * 3, UNCHECKED_COLOR
    .byte $ff, 22 * 5, FRAME_COLOR
