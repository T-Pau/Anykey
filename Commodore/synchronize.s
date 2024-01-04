
; Taken from https://codebase64.org/doku.php?id=base:the_polling_method

.export synchronize

.include "c64.inc"

.code

; synchronizes with raster beam starting at line X
; takes 4 lines
; uses: A X Y

synchronize:
    cpx VIC_RASTER
    bne synchronize
    jsr cycles
    bit $ea
    nop
    cpx VIC_RASTER
    beq skip1
    nop
    nop
skip1:
    jsr cycles
    bit $ea
    nop
    cpx VIC_RASTER
    beq skip2
    bit $ea
skip2:
    jsr cycles
    nop
    nop
    nop
    cpx VIC_RASTER
    bne onecycle
onecycle:
    rts

cycles:
    ldy #$06
:	dey
    bne :-
    inx
    nop
    nop
    rts