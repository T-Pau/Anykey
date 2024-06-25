;  start-mega65.s -- Startup code for MEGA65.
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

.section code

.public start {
    ; enable VIC IV
    lda #$47
    sta VIC_KEY
    lda #$53
    sta VIC_KEY

    lda #14
    sta VIC_BORDER_COLOR

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
}


.section data

message {
    .byte "t'pau was here to save another world!", 0
}

charset {
    .binary_file "charset.bin"
}