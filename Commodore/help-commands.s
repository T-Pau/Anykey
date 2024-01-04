;  help-screen.s -- Text for help screens.
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

.public display_help_page {
    lda current_help_page
    bmi negative
    cmp num_help_screens
    bne ok
    lda #0
    beq ok
negative:
    lda num_help_screens
    sec
    sbc #1
ok:
    sta current_help_page
    asl
    tax

    lda help_screens,x
    sta ptr1
    lda help_screens + 1,x
    sta ptr1 + 1

    lda #<help_screen_title
    sta ptr2
    lda #>help_screen_title
    sta ptr2 + 1
    jsr rl_expand

    lda #<help_screen_text
    sta ptr2
    lda #>help_screen_text
    sta ptr2 + 1
    jmp rl_expand
}


.public help_next {
    inc current_help_page
    jmp display_help_page
}


.public help_previous {
    dec current_help_page
    jmp display_help_page
}


.section reserved

.public current_help_page .reserve 1
