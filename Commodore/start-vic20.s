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
    ldx #<keys_vic20_address_low
    ldy #>keys_vic20_address_low
    lda keys_vic20_num_keys
    jsr set_keys_table
    ;memcpy main_color_save, main_color_plus4, 1000
    lda #KEY_INDEX_HELP
    sta key_index_help
    lda #KEY_INDEX_RESET
    sta key_index_reset

    jsr init_state
    jsr init_restore

    rl_expand main_color_save, main_color

    ldx #1
    stx command

    jsr init_irq

    ldx is_ntsc
    lda hline_offset_table,x
    sta hline_offset

    jsr display_main_screen
    lda #FRAME_COLOR | $8 | (BACKGROUND_COLOR << 3)
    sta VIC_COLOR

    ldx #0
    stx command

    jmp main_loop
}


.section data

hline_offset_table {
    .data 0, SCREEN_TOP_PAL - SCREEN_TOP_NTSC
}

.section reserved

.public hline_offset .reserve 1
