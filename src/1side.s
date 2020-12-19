.autoimport +

.include "anykey.inc"

.macpack cbm_ext
.macpack utility

sprite = $3c00

SPRITE_KEYBOARD_LABEL = sprite / 64
SPRITE_KEYBOARD_LEFT = SPRITE_KEYBOARD_LABEL + 3
SPRITE_KEYBOARD_RIGHT = SPRITE_KEYBOARD_LEFT + 3

.macro delay cycles
.if cycles == 2
	nop
.elseif cycles == 3
	bit $ea
.elseif cycles == 4
	nop
	nop
.elseif cycles == 12
	jsr delay12
.else
.if cycles & 1 == 0
.repeat cycles / 2, i
	nop
.endrepeat
.else
.repeat (cycles - 1) / 2, i
	nop
.endrepeat
	bit $ea
.endif
.endmacro
	
.code

start:
	lda #0
	sta VIC_BORDERCOLOR
	lda #$b
	sta VIC_BG_COLOR0
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
	sta VIC_SPR_ENA


	ldx #<main_irq_table
    ldy #>main_irq_table
    lda main_irq_table_length
    jsr set_irq_table
	jsr init_irq

:	jmp :-

irq_top:
	ldx #(top - 28)
	jsr synchronize
	ldx #(top - 4)
:	cpx VIC_HLINE
	bne :-
	ldx #top
	stx VIC_SPR0_Y
	stx VIC_SPR1_Y
	lda VIC_CTRL2
	tay
	and #$f7
	ldx #(top - 1)
:	cpx VIC_HLINE
	bne :-
	ldx #0 + 8
	stx VIC_SPR0_X
	ldx #<344 - 8
	stx VIC_SPR1_X
	ldx #2
	stx VIC_SPR_HI_X
	ldx #SPRITE_KEYBOARD_LEFT
	stx $07f8
	ldx #SPRITE_KEYBOARD_RIGHT
	stx $07f9
	ldx #$f
	stx VIC_SPR0_COLOR
	stx VIC_SPR1_COLOR
	
	ldx #$b
	
	jsr delay40
	jsr delay34
	
	sta VIC_BG_COLOR0
	stx VIC_BG_COLOR0	
	sta VIC_CTRL2
	nop
	sty VIC_CTRL2
	rts

irq_bottom:
	set_vic_24_lines
	ldx #top + 25 * 8 + 3
:	cpx VIC_HLINE
	bne :-
	set_vic_25_lines
	
	ldx #0
	ldy #SPRITE_KEYBOARD_LABEL
:	tya
	sta $07f8,x
	lda #0
	sta VIC_SPR0_COLOR,x
	iny
	inx
	cpx #3
	bne :-
	
	lda #top-23
	sta VIC_SPR0_Y
	sta VIC_SPR1_Y
	sta VIC_SPR2_Y
	lda #24
	sta VIC_SPR0_X
	lda #(24 + 24)
	sta VIC_SPR1_X
	lda #(24 + 24 * 2)
	sta VIC_SPR2_X
	ldx #0
	stx VIC_SPR_HI_X

	rts
	

delay60:
	nop
delay58:
	nop
delay56:
	nop
delay54:
	nop
delay52:
	nop
delay50:
	nop
delay48:
	nop
delay46:
	nop
delay44:
	nop
delay42:
	nop
delay40:
	nop
delay38:
	nop
delay36:
	nop
delay34:
	nop
delay32:
	nop
delay30:
	nop
delay28:
	nop
delay26:
	nop
delay24:
	nop
delay22:
	nop
delay20:
	nop
delay18:
	nop
delay16:
	nop
delay14:
	nop
delay12:
	rts

delay63:
	nop
delay61:
	nop
delay59:
	nop
delay57:
	nop
delay55:
	nop
delay53:
	nop
delay51:
	nop
delay49:
	nop
delay47:
	nop
delay45:
	nop
delay43:
	nop
delay41:
	nop
delay39:
	nop
delay37:
	nop
delay35:
	nop
delay33:
	nop
delay31:
	nop
delay29:
	nop
delay27:
	nop
delay25:
	nop
delay23:
	nop
delay21:
	nop
delay19:
	nop
delay17:
	nop
delay15:
	bit $ea
	rts

.rodata

sprite_data:
	.incbin "keyboard-label.bin"
	.incbin "keyboard-frame-left.bin"
	.incbin "keyboard-frame-right.bin"

main_irq_table:
	.word top - 30, irq_top
	.word top + 24 * 8 + 7, irq_bottom
main_irq_table_length:
	.byte * - main_irq_table
	