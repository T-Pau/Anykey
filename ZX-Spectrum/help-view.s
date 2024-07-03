;  main-view.s -- main loop and helper functions for main view.
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

NEXT = 1
PREVIOUS = 2
EXIT = 3

.section code

help {
    call reset_keyboard_state
    ld b,PRESSED_COLOR
    ld c,CHECKED_COLOR
    call change_keyboard_colors

    ; save color ram
    ld de,saved_color
    ld hl,color
    ld bc,screen_size
    ldir

    ld h,charset >> 8
    ld l,charset & $ff
    call set_charset
    ld iy,screen_help
    call copy_screen
    ld de,colors_help
    call copy_colors
    ld a,0
    ld (current_page),a
    ld (pressed_key),a
    call display_page

help_loop:
    call handle_keys
    ei
    halt
    di
    jr help_loop
}


display_page {
    rlc a
    ld c,a
    ld b,0
    ld hl,help_screens
    add hl,bc
    ld a,(hl)
    ld (tmp_addr),a
    inc hl
    ld a,(hl)
    ld (tmp_addr + 1),a
    ld iy,(tmp_addr)
    ld hl,screen + 1
    call copy_chars
    ld hl,screen + 64
    call copy_chars
    ld iy,0 ; clear iy so interrupt routine doesn't clobber next help page
    ret
}


handle_keys {
    call read_keys
    cp a,0
    jr nz, got_key
    ld (pressed_key),a
    ret
got_key:
    ld c,a
    ld a,(pressed_key)
    cp a,c
    ret z
    ld a,c
    ld (pressed_key),a
    dec a
    jr nz,not_next
    ; next page
    ld a,(current_page)
    inc a
    ld c,a
    ld a,(help_screens_count)
    cp a,c
    ld a,c
    jr nz,next_no_wraparound
    ld a,0
next_no_wraparound:
    ld (current_page),a
    call display_page
    ret
not_next:
    dec a
    jr nz,not_previous
    ; previous page
    ld a,(current_page)
    cp a,0
    jr nz,previous_no_wraparound
    ld a,(help_screens_count)
previous_no_wraparound:
    dec a
    ld (current_page),a
    call display_page
    ret
not_previous:
    ; return to main view
    ld iy,screen_main
    call copy_screen
    ; restore color
    ld de,color
    ld hl,saved_color
    ld bc,screen_size
    ldir

    jp main_loop
}


read_keys {
    ld a,$7f
    in a,($fe)
    bit 0,a
    jr nz,no_space
    ld a,NEXT
    ret
no_space:
    ld a,$df
    in a,($fe)
    bit 0,a
    jr nz,no_p
    ld a,PREVIOUS
    ret
no_p:
    ld a,$f7
    in a,($fe)
    bit 0,a
    jr nz,no_1
    ld a,EXIT
    ret
no_1:
    ld a,0
    ret
}


reset_keyboard_state {
    ld b,num_keys
    ld a,0
    ld hl,key_state
reset_state_loop:
    ld (hl),a
    inc hl
    djnz reset_state_loop
    ret
}


.section reserved

current_page .reserve 1
pressed_key .reserve 1
tmp_addr .reserve 2
saved_color .reserve screen_size
