;  init-c64.s -- C64 specific initialization
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

.section code

.public init {
    lda #1
    sta VIC_SPRITE_0_X
    lda #VIC_KNOCK_IV_1
    sta VIC_KEY
    lda #VIC_KNOCK_IV_2
    sta VIC_KEY
    lda #0
    sta VIC_PALETTE_RED
    lda VIC_SPRITE_0_X
    beq not_m65
    lda #MACHINE_TYPE_MEGA65
    bne end_detect
not_m65:
    lda VIC_CLK_128
    cmp #$ff
    beq not_128
    lda #MACHINE_TYPE_C128
    bne end_detect
not_128:
    ldx VIC_RASTER
    inx
    inx
    inx
    ldy #$40
:   dey
    bpl :-
    cpx VIC_RASTER
    bcs acelleration_detected
    lda #0
    sta acellerated
    beq end_detect
acelleration_detected:
    lda #1
    sta acellerated
;    sta main_screen_64
    lda #MACHINE_TYPE_C64
end_detect:
    sta machine_type
    rts
}
