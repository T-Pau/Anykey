;  copy-screen.asm -- Copy characters to screen RAM.
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

; hl - address of charset
.global set_charset {
    ld a,l
    ld (current_charset),a
    ld a,h
    ld (current_charset + 1),a
    ret
}

; iy - chars to copy from
.global copy_screen {
    ld hl, screen
    ; fallthrough

; iy - chars to copy from
; hl - screen position to copy to
.global copy_chars:
    ld a,(iy)
    inc iy
    cp a,$fe
    jr nz,no_skip
    ld a,(iy)
    inc iy
    add a,l
    ld l,a
    jr nc,copy_chars
    ld a,8
    add a,h
    ld h,a
    jr copy_chars
no_skip:
    ld c,1
    cp a,$ff
    jr nz,no_runlength
    ld a,(iy)
    inc iy
    cp a,0
    ret z
    ld c,a
    ld a,(iy)
    inc iy
no_runlength:
    ; calculate address of character in set
    ld e,a
    ld d,0
    scf
    ccf
    rl de
    rl de
    rl de
    ld a,(current_charset)
    add a,e
    ld e,a
    ld a,(current_charset + 1)
    adc a,d
    ld d,a

runlength_loop:
    ; copy character
    ld b, 8
copy_char_loop:
    ld a,(de)
    ld (hl),a
    inc h
    inc de
    djnz copy_char_loop

    inc l
    jr z,runlength_next
    ld a,h
    sub 8
    ld h,a
runlength_next:
    dec c
    jr z,copy_chars
    ld a,e
    sub 8
    ld e,a
    ld a,d
    sbc 0
    ld d,a
    jr runlength_loop
}


.section reserve

current_charset .reserve 2
