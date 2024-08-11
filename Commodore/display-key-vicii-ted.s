;  display_key-vicii-ted.s -- Display current_key_state of key, VIC-II / TED version
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

COLOR_RAM_OFFSET = >color_ram - >screen

.macro set_color pointer = ptr1 {
    .if COLOR_RAM_OFFSET > 0 {
        clc
        lda pointer + 1
        adc #COLOR_RAM_OFFSET
        sta pointer + 1
    }
    .else {
        sec
        lda pointer + 1
        sbc #-COLOR_RAM_OFFSET
        sta pointer + 1
    }

    lda current_key_color
    ldy #0
}

.section code

.public display_key_2 {
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #40
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    set_color
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #40
    sta (ptr1),y
    iny
    sta (ptr1),y
    
    rts
}


.public display_key_3 {
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #40
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    
    set_color
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #40
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y

    rts
}

.public display_key_4_short {
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    set_color
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #40
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y

    rts
}


.public display_key_4 {
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #40
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    set_color
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #40
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y

    rts
}


.public display_key_2_2 {
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #40
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #80
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #120
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    set_color
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #40
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #80
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #120
    sta (ptr1),y
    iny
    sta (ptr1),y

    rts
}


.public display_key_2_3 {
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #40
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #80
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #120
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    set_color
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #40
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #80
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #120
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y

    rts
}


.public display_key_17 {
    clc
    lda ptr1
    adc #40
    sta ptr2
    lda ptr1 + 1
    adc #0
    sta ptr2 + 1

    ldy #16
:	lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    lda (ptr2),y
    and #$7f
    ora current_key_state
    sta (ptr2),y
    dey
    bpl :-

    set_color ptr2
    set_color

    ldy #16
:	sta (ptr1),y
    sta (ptr2),y
    dey
    bpl :-

    rts
}


.public display_key_18 {
    clc
    lda ptr1
    adc #40
    sta ptr2
    lda ptr1 + 1
    adc #0
    sta ptr2 + 1

    ldy #17
:	lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    lda (ptr2),y
    and #$7f
    ora current_key_state
    sta (ptr2),y
    dey
    bpl :-

    set_color ptr2
    set_color

    ldy #17
:	sta (ptr1),y
    sta (ptr2),y
    dey
    bpl :-

    rts
}

.public display_key_20 {
    clc
    lda ptr1
    adc #40
    sta ptr2
    lda ptr1 + 1
    adc #0
    sta ptr2 + 1

    ldy #19
:	lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    lda (ptr2),y
    and #$7f
    ora current_key_state
    sta (ptr2),y
    dey
    bpl :-

    set_color ptr2
    set_color

    ldy #19
:	sta (ptr1),y
    sta (ptr2),y
    dey
    bpl :-

    rts
}


.public display_key_down {
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #41
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    
    set_color
    iny
    sta (ptr1),y
    ldy #40
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y

    rts
}


.public display_key_up {
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #41
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    
    set_color
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #41
    sta (ptr1),y

    rts
}


.public display_key_plus4_control {
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #40
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #29
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #69
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    set_color
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #40
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #29
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #69
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y

    rts
}

.public display_key_plus4_shift {
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #40
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #80
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #120
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #103
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #143
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    set_color
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #40
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #80
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #120
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #103
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #143
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    rts
}


.public display_key_c116_shift {
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #40
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #23
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    ldy #63
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y
    iny
    lda (ptr1),y
    and #$7f
    ora current_key_state
    sta (ptr1),y

    set_color
    ldy #0
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #40
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #23
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    ldy #63
    sta (ptr1),y
    iny
    sta (ptr1),y
    iny
    sta (ptr1),y
    rts
}
