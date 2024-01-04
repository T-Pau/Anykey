sprite = $3c00

SPRITE_KEYBOARD_LABEL = sprite / 64
SPRITE_KEYBOARD_LEFT = SPRITE_KEYBOARD_LABEL + 3
SPRITE_KEYBOARD_RIGHT = SPRITE_KEYBOARD_LEFT + 3

.macro delay cycles {
    .if cycles == 2 {
        nop
    }
    .else_if cycles == 3 {
        bit $ea
    }
    .else_if cycles == 4 {
        nop
        nop
    }
    .else_if cycles == 12 {
        jsr delay12
    }
    .else {
        .if cycles & 1 == 0 {
            .repeat cycles / 2 {
                nop
            }
        }
        .else {
            .repeat (cycles - 1) / 2 {
                nop
            }
           bit $ea
        }
    }
}
    
.section code

start {
    lda #0
    sta VIC_BORDER_COLOR
    lda #$b
    sta VIC_BACKGROUND_COLOR
    lda #0
    sta $3fff
    
    ldx #0
:	txa
    sta $0400,x
    inx
    cpx #40
    bne :-
    
    memcpy sprite, sprite_data, 64 * 9
    
    lda #7
    sta VIC_SPRITE_ENABLE


    ldx #<main_irq_table
    ldy #>main_irq_table
    lda main_irq_table_length
    jsr set_irq_table
    jsr init_irq

:	jmp :-
}

irq_top {
    ldx #(top - 28)
    jsr synchronize
    ldx #(top - 4)
:	cpx VIC_RASTER
    bne :-
    ldx #top
    stx VIC_SPRITE_0_Y
    stx VIC_SPR1_Y
    lda VIC_CTRL2
    tay
    and #$f7
    ldx #(top - 1)
:	cpx VIC_RASTER
    bne :-
    ldx #0 + 8
    stx VIC_SPRITE_0_X
    ldx #<344 - 8
    stx VIC_SPR1_X
    ldx #2
    stx VIC_SPRITE_X_MSB
    ldx #SPRITE_KEYBOARD_LEFT
    stx $07f8
    ldx #SPRITE_KEYBOARD_RIGHT
    stx $07f9
    ldx #$f
    stx VIC_SPRITE_0_COLOR
    stx VIC_SPR1_COLOR
    
    ldx #$b
    
    jsr delay40
    jsr delay34
    
    sta VIC_BACKGROUND_COLOR
    stx VIC_BACKGROUND_COLOR
    sta VIC_CTRL2
    nop
    sty VIC_CTRL2
    rts
}

irq_bottom {
    set_vic_24_lines
    ldx #top + 25 * 8 + 3
:	cpx VIC_RASTER
    bne :-
    set_vic_25_lines
    
    ldx #0
    ldy #SPRITE_KEYBOARD_LABEL
:	tya
    sta $07f8,x
    lda #0
    sta VIC_SPRITE_0_COLOR,x
    iny
    inx
    cpx #3
    bne :-
    
    lda #top-23
    sta VIC_SPRITE_0_Y
    sta VIC_SPR1_Y
    sta VIC_SPR2_Y
    lda #24
    sta VIC_SPRITE_0_X
    lda #(24 + 24)
    sta VIC_SPR1_X
    lda #(24 + 24 * 2)
    sta VIC_SPR2_X
    ldx #0
    stx VIC_SPRITE_X_MSB

    rts
}


delay60 {
    nop
.local delay58:
    nop
.local delay56:
    nop
.local delay54:
    nop
.local delay52:
    nop
.local delay50:
    nop
.local delay48:
    nop
.local delay46:
    nop
.local delay44:
    nop
.local delay42:
    nop
.local delay40:
    nop
.local delay38:
    nop
.local delay36:
    nop
.local delay34:
    nop
.local delay32:
    nop
.local delay30:
    nop
.local delay28:
    nop
.local delay26:
    nop
.local delay24:
    nop
.lcoal delay22:
    nop
.local delay20:
    nop
.local delay18:
    nop
.local delay16:
    nop
.local delay14:
    nop
.local delay12:
    rts
}

delay63 {
    nop
.local delay61:
    nop
.local delay59:
    nop
.local delay57:
    nop
.local delay55:
    nop
.local delay53:
    nop
.local delay51:
    nop
.local delay49:
    nop
.local delay47:
    nop
.local delay45:
    nop
.local delay43:
    nop
.local delay41:
    nop
.local delay39:
    nop
.local delay37:
    nop
.local delay35:
    nop
.local delay33:
    nop
.local delay31:
    nop
.local delay29:
    nop
.local delay27:
    nop
.local delay25:
    nop
.local delay23:
    nop
.local delay21:
    nop
.local delay19:
    nop
.local delay17:
    nop
.local delay15:
    bit $ea
    rts
}

.section data

sprite_data {
    .binary_file "keyboard-label.bin"
    .binary_file "keyboard-frame-left.bin"
    .binary_file "keyboard-frame-right.bin"
}

main_irq_table {
    .data top - 30:2, irq_top
    .data top + 24 * 8 + 7:2, irq_bottom
}
main_irq_table_length {
    .data .sizeof(main_irq_table)
}
