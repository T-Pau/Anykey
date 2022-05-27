;  main-view.asm -- main loop and helper functions for main view.
;  Copyright (C) 2022 Dieter Baron
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

public help

include "platform.inc"
include "keyboard.inc"

global copy_screen, copy_colors, main_loop

NEXT = 1
PREVIOUS = 2
EXIT = 3

section code_user

help:
    call reset_keyboard_state
    ld b,PRESSED_COLOR
    ld c,CHECKED_COLOR
    call change_keyboard_colors

    ; save color ram
    ld de,saved_color
    ld hl,color
    ld bc,screen_size
    ldir

    ld iy,screen_help
    call copy_screen
    ld de,colors_help
    call copy_colors
    ld a,0
    ld (current_page),a
    ld (current_key),a
    call display_page

help_loop:
    call handle_keys
    ei
    halt
    di
    jr help_loop

display_page:
    ; TODO; implement
    ret

handle_keys:
    call read_keys
    cp a,0
    ret z
    ld c,a
    ld a,(current_key)
    cp a,c
    ret z
    ld a,c
    ld (current_key),a
    dec a
    jr nz,not_next
    ; handle next
    ret
not_next:
    dec a
    jr nz,not_previous
    ; handle previous
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

read_keys:
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


reset_keyboard_state:
    ld b,num_keys
    ld a,0
    ld hl,key_state
reset_state_loop:
    ld (hl),a
    inc hl
    djnz reset_state_loop
    ret


section bss_user

current_page:
    defs 1

current_key:
    defs 1

saved_color:
    defs screen_size
