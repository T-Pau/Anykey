.include "cbm_kernal.inc"

.include "mega65.inc"

.code

start:
    ; enable VIC IV
    lda #$47
	sta VIC_KEY
	lda #$53
	sta VIC_KEY

    lda #14
    sta VIC_BORDERCOLOR

	lda #<charset
	sta VIC_CHARSET_PTR
	lda #>charset
	sta VIC_CHARSET_PTR + 1
	lda #0
	sta VIC_CHARSET_BANK
	lda #1
	sta VIC_CHAR_Y_SCALE
	lda #50
	sta VIC_DISPLAY_ROWS

    ldx #0
loop:
    lda message,x
    beq end
    jsr CHROUT
    inx
    bne loop
end:
    rts

.rodata

message:
    .byte "t'pau was here to save another world!", 0

charset:
    .incbin "charset.bin"
