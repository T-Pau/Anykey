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

public main_loop

include "platform.inc"
include "keyboard.inc"

section code_user

main_loop:
    call read_keyboard
    call display_keyboard
    call handle_keys_main
    ei
    halt
    di
    jr main_loop

handle_keys_main:
    ld ix,key_state
    ld a,(ix + KEY_INDEX_RESET)
    cp a,0
    jr z,not_reset
    ld a,(reset_pressed)
    inc a
    ld (reset_pressed),a
    cp a,PRESS_DURATION
    jr c,check_help
    call reset_keyboard
    jr check_help
not_reset:
    ld (reset_pressed),a
check_help:
    ld a,(ix + KEY_INDEX_HELP)
    cp a,0
    jr z,not_help
    ld a,(help_pressed)
    inc a
    ld (help_pressed),a
    cp a,PRESS_DURATION
    ret c
    ; TODO: help
    ret
not_help:
    ld (help_pressed),a
    ret

section bss_user

reset_pressed:
    defs 1

help_pressed:
    defs 1
