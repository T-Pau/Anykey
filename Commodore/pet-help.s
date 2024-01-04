;  pet-help.s -- Display help page on PET.
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

.public display_help_screen {
    store_word saved_screen, ptr2
    store_word screen, ptr1
    lda saved_screen_size
    sta ptr3
    lda saved_screen_size + 1
    sta ptr3 + 1
    jsr memcpy
    store_word screen, ptr2
    lda help_footer
    sta ptr1
    lda help_footer + 1
    sta ptr1 + 1
    jsr rl_expand
    ldx #0
    beq update_help_page
}


.public help_next {
    ldx current_page
    inx
    cpx help_count
    bne update_help_page
    ldx #0
    jmp update_help_page
}

.public help_previous {
    ldx current_page
    dex
    bpl update_help_page
    ldx help_count
    dex
    jmp update_help_page
}

.public update_help_page {
    stx current_page
    store_word help_pages, ptr2
    ldy #0
    lda (ptr2),y
    sta ptr3
    iny
    lda (ptr2),y
    sta ptr3 + 1
    txa
    asl
    tay
    lda (ptr3),y
    sta ptr1
    iny
    lda (ptr3),y
    sta ptr1 + 1
    store_word screen, ptr2
    jmp rl_expand
}


.public display_main_screen {
    store_word screen, ptr2
    store_word saved_screen, ptr1
    lda saved_screen_size
    sta ptr3
    lda saved_screen_size + 1
    sta ptr3 + 1
    jsr memcpy
    ldx #$ff
    stx current_page
    rts
}

.section reserve

.public current_page .reserve 1  ; $ff when not in help mode
