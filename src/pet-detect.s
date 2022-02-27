; ROM 1 -> 40 calculator
; ROM 2 - > 40 business or graphics
; ROM 4 -> 40 graphics or business, or 80 calculator or business or calculator

.autoimport +

.export detect, rom_version, line_width, keyboard_type

.export detect_keyboard ; DEBUG

.include "defines.inc"
.include "pet-detect.inc"

.macpack utility

.code

detect:
    jsr detect_rom_version
    jsr detect_line_width
    jmp detect_keyboard


detect_rom_version:
.scope
    ldx #0
version_loop:
    lda rom_offset,x
    sta ptr1
    bne :+
    lda #$ff
    bne end
:   lda rom_offset + 1,x
    sta ptr1 + 1
    lda rom_message,x
    sta ptr2
    lda rom_message + 1,x
    sta ptr2 + 1
    ldy #0
byte_loop:
    lda (ptr2),y
    beq version_found
    cmp (ptr1),y
    bne :+
    iny
    bne byte_loop
:   inx
    inx
    bne version_loop
version_found:
    txa
    lsr
end:
    sta rom_version
    rts
.endscope


; requires rom_version to be set
detect_line_width:
.scope
    ldx #0
    lda rom_version
    bpl :+
    dex
    bne end
:   cmp #ROM_4
    bne end
    lda LNMX
    cmp #39
    beq end
    inx
end:
    stx line_width
    rts
.endscope


; requires rom_version and line_width to be set
detect_keyboard:
.scope
    lda rom_version
    bpl rom_ok
not_recognized:
    ldx #$ff
    bne end
rom_ok:
    cmp #ROM_1
    bne :+
    ldx #KEYBOARD_CALCULATOR
    jmp end
:   cmp #ROM_4
    bne :+
    clc
    adc line_width
    bcs not_recognized
:   asl
    tax
    lda keyboard_offset,x
    sta ptr1
    lda keyboard_offset + 1,x
    sta ptr1 + 1
    store_word keyboard_matrix, ptr2
    ldx #0
loop_type:
    ldy #$f
:   lda (ptr2),y
    cmp (ptr1),y
    bne type_end
    dey
    bpl :-
end:
    stx keyboard_type
    rts
type_end:
    inx
    cpx #3
.if 1
    beq not_recognized
.else
    ; For 40 columns, detection only works for graphics keyboard, so for now assume business keyboard if not recognized.
    bne next_type
    lda line_width
    bne not_recognized
    ldx #KEYBOARD_BUSINESS
    jmp end
next_type:
.endif
    add_word ptr2, $10
    bne loop_type
.endscope

.bss

rom_version:
    .res 1

line_width:
    .res 1

keyboard_type:
    .res 1

.rodata

rom_offset:
    .word $e180
    .word $e1c4
    .word $dea4
    .word 0

rom_message:
    .word rom_1
    .word rom_2
    .word rom_4

rom_1:
    .byte $2A, $2A, $2A, $20, $43, $4F, $4D, $4D, $4F, $44, $4F, $52, $45, $20, $42, $41
    .byte $53, $49, $43, $20, $2A, $2A, $2A, 0

rom_2:
    .byte $23, $23, $23, $20, $43, $4F, $4D, $4D, $4F, $44, $4F, $52, $45, $20, $42, $41
    .byte $53, $49, $43, $20, $23, $23, $23, 0

rom_4:
    .byte $2A, $2A, $2A, $20, $43, $4F, $4D, $4D, $4F, $44, $4F, $52, $45, $20, $42, $41
    .byte $53, $49, $43, $20, $34, $2E, $30, $20, $2A, $2A, $2A, 0


keyboard_offset:
    .word $e75c ; ROM 1
    .word $e6f8 ; ROM 2
    ;.word $e60b ; ROM 4 40 columns
    .word $e73f ; ROM 4 40 columns
    .word $e6d1 ; ROM 4 80 columns

keyboard_matrix:
    ; business
    .byte $16, $04, $3a, $03, $39, $36, $33, $df
    .byte $b1, $2f, $15, $13, $4d, $20, $58, $12
    ; calculator
    .byte $3d, $2e, $10, $03, $3c, $20, $5b, $12
    .byte $2d, $30, $00, $3e, $ff, $5d, $40, $00
    ; graphics
    .byte $3d, $2e, $ff, $03, $3c, $20, $5b, $12
    .byte $2d, $30, $00, $3e, $ff, $5d, $40, $00
