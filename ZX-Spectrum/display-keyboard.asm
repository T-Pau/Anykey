;  display-keyboard.asm -- Update keyboard to new state.
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

.global display_keyboard {
    ld ix,keys_48k
    ld iy,key_state
    ld a,num_keys
    ld (current_key),a

display_loop:
    ld a,(iy+num_keys) ; new state
    cp a,(iy) ; old state
    jr z,next_key

    ld (iy),a
    ld c,CHECKED_COLOR
    or a
    jr z, not_pressed
    ld c,PRESSED_COLOR
not_pressed:
    ld l,(ix + key_display_routine)
    ld h,(ix + key_display_routine + 1)
    call display_key

next_key:
    inc iy
    ld e,key_size
    ld d,0
    add ix,de
    ld a,(current_key)
    dec a
    ret z
    ld (current_key),a
    jr display_loop
}


display_key {
    jp (hl)
    ret
}

.section reserve

.global key_state .reserve num_keys
.global new_key_state .reserve num_keys

current_key .reserve 1
