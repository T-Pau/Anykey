.autoimport +

.include "c64.inc"

top = 50 ; first raster line of screen

.macpack cbm_ext

sprite = $3c00

.code

start:
    lda #0
    sta VIC_BORDER_COLOR
    lda #$b
    sta VIC_BACKGROUND_COLOR
    lda #0
    sta $3fff
    
    ldx #62
    lda #$ff
:	sta sprite,x
    dex
    bpl :-
    
    lda #$7f
    sta VIC_SPRITE_ENABLE
    sta VIC_SPRITE_EXPAND_X
    sta VIC_SPRITE_EXPAND_Y
    lda #0
    sta VIC_SPRITE_PRIORITY
    
    ldx #7
:	lda #sprite/64
    sta $07f8,x
    lda #$b
    sta VIC_SPRITE_0_COLOR,x
    dex
    bpl :-
    
    ldx #24
    stx sprite_x
    ldx #0
    stx sprite_x + 1
    ldy #(top + 25 * 8)
    sty sprite_y
    
    lda #0
    jsr set_sprite
    
    clc
    lda sprite_x
    adc #48
    sta sprite_x
    bcc :+
    inc sprite_x + 1
:	lda #1
    jsr set_sprite

    clc
    lda sprite_x
    adc #48
    sta sprite_x
    bcc :+
    inc sprite_x + 1
:	lda #2
    jsr set_sprite

    clc
    lda sprite_x
    adc #48
    sta sprite_x
    bcc :+
    inc sprite_x + 1
:	lda #3
    jsr set_sprite

    clc
    lda sprite_x
    adc #48
    sta sprite_x
    bcc :+
    inc sprite_x + 1
:	lda #4
    jsr set_sprite

    clc
    lda sprite_x
    adc #48
    sta sprite_x
    bcc :+
    inc sprite_x + 1
:	lda #5
    jsr set_sprite
    
    clc
    lda sprite_x
    adc #48
    sta sprite_x
    bcc :+
    inc sprite_x + 1
:	lda #6
    jsr set_sprite
    
    
    ldx #<main_irq_table
    ldy #>main_irq_table
    lda main_irq_table_length
    jsr set_irq_table
    jsr init_irq

:	jmp :-

irq_routine:
    set_vic_24_lines
    ldx #top + 25 * 8 + 3
:	cpx VIC_RASTER
    bne :-
    set_vic_25_lines
    
    inc VIC_BORDER_COLOR
    jsr delay
    dec VIC_BORDER_COLOR
    
    dec VIC_BORDER_COLOR
    lda VIC_C128_CLOCK
    ora #1
    sta VIC_C128_CLOCK
    jsr delay
    and #$fe
    sta VIC_C128_CLOCK
    inc VIC_BORDER_COLOR
    
    rts
    
delay:
    ldx #$80
:	dex
    bne :-
    rts


.section data

main_irq_table:
    .word top + 24 * 8 + 7, irq_routine
main_irq_table_length:
    .byte * - main_irq_table
    