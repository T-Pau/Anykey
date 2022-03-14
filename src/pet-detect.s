;  pet-detect.s -- Detect PET model and keyboard type.
;  Copyright (C) 2022 Dieter Baron
;
;  This file is part of Anykey, a keyboard test program for C64.
;  The authors can be contacted at <anykey@tpau.group>.
;
;  Redistribution and use in source and binary forms, with or without
;  modification, are permitted provided that the following conditions
;  are met:
;  1. Redistributions of source code must retain the above copyright
;     notice, this list of conditions and the following disclaimer.
;  2. The names of the authors may not be used to endorse or promote
;     products derived from this software without specific prior
;     written permission.
;
;  THIS SOFTWARE IS PROVIDED BY THE AUTHORS ``AS IS'' AND ANY EXPRESS
;  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;  ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY
;  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
;  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
;  IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
;  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
;  IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
    lda rom_offset + 1,x
    bne :+
    lda #$ff
    bne end
:   sta ptr1 + 1
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
    tax
    lda rom_version_number,x
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
    bcc end
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
    beq calculator
    cmp #ROM_4_1
    bne not_calculator
calculator:
    ldx #KEYBOARD_CALCULATOR
    bne end
not_calculator:
    cmp #ROM_2
    bne not_rom_2
    lda $e220
    cmp #$a9
    bne not_recognized
    ldx #2
:   lda $e222,x
    cmp screen_mode,x
    bne not_recognized
    dex
    bpl :-
    lda $e221
    cmp #$0c
    bne :+
    ldx #KEYBOARD_GRAPHICS
    bne end
:   cmp #$0e
    bne not_recognized
    ldx #KEYBOARD_BUSINESS
    beq end
not_rom_2:
    lda line_width
    bmi not_recognized
    asl
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
    txa
    asl
    tax
end:
    stx keyboard_type
    rts
type_end:
    inx
    cpx #2
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
    .word $dec2
    .word $dea4
    .word 0

rom_message:
    .word rom_1
    .word rom_2
    .word rom_41
    .word rom_4

rom_version_number:
    .byte ROM_1, ROM_2, ROM_4_1, ROM_4

rom_1:
    .byte $2A, $2A, $2A, $20, $43, $4F, $4D, $4D, $4F, $44, $4F, $52, $45, $20, $42, $41
    .byte $53, $49, $43, $20, $2A, $2A, $2A, 0

rom_2:
    .byte $23, $23, $23, $20, $43, $4F, $4D, $4D, $4F, $44, $4F, $52, $45, $20, $42, $41
    .byte $53, $49, $43, $20, $23, $23, $23, 0

rom_4:
    .byte $2A, $2A, $2A, $20, $43, $4F, $4D, $4D, $4F, $44, $4F, $52, $45, $20, $42, $41
    .byte $53, $49, $43, $20, $34, $2E, $30, $20, $2A, $2A, $2A, 0

rom_41:
    .byte $2a, $2a, $2a, $20, $4d, $49, $4e, $49, $20, $50, $45, $54, $20, $42, $41, $53
    .byte $49, $43, $20, $34, $2e, $31, $20, $2a, $2a, $2a, 0

; ROM 2

screen_mode:
    .byte $8d, $4c, $e8

; ROM 4
keyboard_offset:
    .word $e73f ; 40 columns
    .word $e6d1 ; 80 columns

keyboard_matrix:
    ; business
    .byte $16, $04, $3a, $03, $39, $36, $33, $df
    .byte $b1, $2f, $15, $13, $4d, $20, $58, $12
    ; graphics
    .byte $3d, $2e, $10, $03, $3c, $20, $5b, $12
    .byte $2d, $30, $00, $3e, $ff, $5d, $40, $00
