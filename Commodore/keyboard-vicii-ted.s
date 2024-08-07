;  keyboard.s -- Process and display keyboard state, VIC-II / TED specific
;  Copyright (C) Dieter Baron
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
;  THIS SOFTWARE IS PROVIDED BY THE AUTHORS "AS IS" AND ANY EXPRESS
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

.include "features.inc"

.section code

.public reset_keyboard {
    lda keyboard_height
    cmp #12
    beq low
    store_word ptr3, 40 * 12
    bne both
low:
    store_word ptr3, 40 * 10
both:
    store_word ptr1, screen + 40 * 2
    store_word ptr2, color_ram + 40 * 2
    ldy #0
    ldx ptr3 + 1
    beq partial
loop:
    lda (ptr1),y
    cmp #$a0
    beq :+
    lda (ptr2),y
    .if .defined(USE_VICII) {
        and #$0f
    }
    cmp #CHECKED_COLOR
    bne :+
    lda #UNCHECKED_COLOR
    sta (ptr2),y
:	iny
    bne loop
    inc ptr1 + 1
    inc ptr2 + 1
    dex
    bne loop

partial:
    ldx ptr3
    beq end
partial_loop:
    lda (ptr1),y
    cmp #$a0
    beq :+
    lda (ptr2),y
    .if .defined(USE_VICII) {
        and #$0f
    }
    cmp #CHECKED_COLOR
    bne :+
    lda #UNCHECKED_COLOR
    sta (ptr2),y
:	iny
    dex
    bne partial_loop
end:
    rts
}
