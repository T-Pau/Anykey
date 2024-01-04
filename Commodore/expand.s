;  expand.s -- expand run length encoded data.
;  Copyright (C)  Dieter Baron
;
;  This file is part of Zak Supervisor, a Music Monitor for the Commodore 64.
;  The authors can be contacted at <zak-supervisor@tpau.group>.
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

.public expand {
    ldy #0
loop:
    lda (ptr1),y
    bmi runlength
    sta (ptr2),y
    iny
    bne loop
    inc ptr1 + 1
    inc ptr2 + 1
    bne loop
runlength:
    cmp #$ff
    bne :+
    rts
:	and #$7f
    sta tmp1
    tya
    clc
    adc_16 ptr2
    tya
    sec
    adc_16 ptr1
    ldy #0
    lda (ptr1),y
    ldy tmp1
    dey
runlength_loop:
    sta (ptr2),y
    dey
    bpl runlength_loop
    lda tmp1
    clc
    adc_16 ptr2
    inc_16 ptr1
    ldy #0
    beq loop
}
