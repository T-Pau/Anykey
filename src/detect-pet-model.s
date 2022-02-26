.autoimport +

.include "pet-detect.inc"
.include "cbm_kernal.inc"

start:
.scope
    jsr detect
    ldx rom_version
    bpl :+
    lda #$3f
    bne version
:   lda rom_version_name,x
version:
    jsr CHROUT

    ldx line_width
    bpl :+
    lda #$3f
    bne width
:   lda line_width_name,x
width:
    jsr CHROUT

    ldx keyboard_type
    bpl :+
    lda #$3f
    bne type
:   lda keyboard_type_name,x
type:
    jsr CHROUT
    lda #$0d
    jmp CHROUT
.endscope

.rodata

rom_version_name:
    .byte "124"
line_width_name:
    .byte "48-"
keyboard_type_name:
    .byte "bcg"
