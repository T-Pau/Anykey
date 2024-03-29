;  detect-pet.s -- Detect and display PET model and keyboard type.
;  Copyright (C) 2020 Dieter Baron
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

.include "defines.inc"
.include "pet-detect.inc"

.macpack utility

start:
.scope
    jsr detect
    store_word rom_version_header, ptr1
    jsr output_string
    ldx rom_version
    bpl :+
    jsr print_unknown
    jmp width
:   store_word rom_version_name, ptr1
    lda #4
    jsr print_name

width:
    store_word line_width_header, ptr1
    jsr output_string
    ldx line_width
    bpl :+
    jsr print_unknown
    jmp type
:   store_word line_width_name, ptr1
    lda #4
    jsr print_name

type:
    store_word keyboard_type_header, ptr1
    jsr output_string
    ldx keyboard_type
    bpl :+
    jsr print_unknown
    jmp end
:   store_word keyboard_type_name, ptr1
    lda #16
    jsr print_name

end:
    jsr CHROUT
    lda #$0d
    jmp CHROUT
.endscope


print_unknown:
    store_word unknown, ptr1
    jmp output_string

print_name:
.scope
    tay
    cpx #0
    beq done
loop:
    tya
    clc
    adc_16 ptr1
    dex
    bne loop
done:
    jmp output_string
.endscope

output_string:
.scope
    ldy #0
loop:
    lda (ptr1),y
    bne :+
    rts
:   jsr CHROUT
    iny
    bne loop
.endscope


.rodata

rom_version_name:
    .byte "1", 0, 0, 0
    .byte "2", 0, 0, 0
    .byte "4.0", 0
    .byte "4.1", 0

line_width_name:
    .byte "40", 0, 0
    .byte "80", 0, 0

keyboard_type_name:
    .byte "business", 0, 0, 0, 0, 0, 0, 0, 0
    .byte "calculator", 0, 0, 0, 0, 0, 0
    .byte "graphics", 0, 0, 0, 0, 0, 0, 0, 0

unknown:
    .byte "unknown", 0

rom_version_header:
    .byte      "rom version: ", 0

line_width_header:
    .byte $0d, "line width:  ", 0

keyboard_type_header:
    .byte $0d, "keyboard:    ", 0
