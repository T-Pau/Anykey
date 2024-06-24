;  start.s -- Entry point of program.
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
    jsr init

    jsr init_state

    rl_expand charset, charset_data
    rl_expand_typed charset_keyboard_top, charset_keyboard_c64_top, charset_keyboard_c128_top, charset_keyboard_mega65_c64_top
    rl_expand_typed charset_keyboard_bottom, charset_keyboard_c64_bottom, charset_keyboard_c128_bottom, charset_keyboard_mega65_c64_bottom
    memcpy sprites, sprite_data, (64 * 8)

    jsr display_main_screen
    lda #FRAME_COLOR
    sta VIDEO_BORDER_COLOR

    set_vic_bank $8000
    set_vic_text screen, charset

    lda #$0f
    sta VIC_SPRITE_ENABLE
    lda #0
    sta VIC_SPRITE_PRIORITY
    sta VIC_SPRITE_EXPAND_X
    sta VIC_SPRITE_EXPAND_Y
    sta VIC_SPRITE_MULTICOLOR

    jsr setup_logo

    lda #$ff
    sta CIA1_DDRA
    sta CIA1_DDRB

    jsr init_irq
    
    jmp main_loop
}