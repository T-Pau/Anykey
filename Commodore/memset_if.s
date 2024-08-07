;  memset_if.s -- Change all bytes of one value in region to another.
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


.public .macro memset_if destination, old_value, new_value, length {
    store_word ptr2, destination
    store_word ptr3, length
    ldx #new_value
    lda #old_value
    jsr memset_if
}

; change ptr3 bytes at ptr2 to X if they are A

.section reserved

if_value .reserve 1
new_value .reserve 1
    
.section code

.public memset_if {
    stx new_value
    sta if_value
    ldy #0
    ldx ptr3 + 1
    beq partial
loop:
    cmp (ptr2),y
    bne :+
    lda new_value
    sta (ptr2),y
    lda if_value
:	iny
    bne loop
    inc ptr2 + 1
    dex
    bne loop

partial:
    ldx ptr3
    beq end
partial_loop:
    cmp (ptr2),y
    bne :+
    lda new_value
    sta (ptr2),y
    lda if_value
:	iny
    dex
    bne partial_loop
end:
    rts
}
