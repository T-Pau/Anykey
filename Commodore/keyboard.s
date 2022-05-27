;  keyboard.s -- Process and display keyboard state
;  Copyright (C) 2020-2022 Dieter Baron
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


.autoimport +

.export init_keyboard, display_keyboard, read_keyboard
.export key_index_help, key_index_reset
.export key_state, new_key_state, bitmask

.if .defined(__C64__) .or .defined(__MEGA65__)
.export set_keyboard_registers, read_keyboard_mega65
.endif

.include "defines.inc"

.macpack utility

.ifdef USE_PET
MAX_KEY_READ = 80
.else
MAX_KEY_READ = 64
.endif

.bss

key_state:
	.res MAX_NUM_KEYS

new_key_state:
	.res MAX_NUM_KEYS + 1

key_index_help:
    .res 1
key_index_reset:
    .res 1
   
reset_count:
	.res 1
help_count:
	.res 1

.code

init_keyboard:
	ldx #MAX_NUM_KEYS
	lda #0
:	sta key_state,x
	sta new_key_state,x
	dex
	bpl :-
	sta reset_count
	sta help_count
.ifdef USE_VICII
	jsr init_keyboard_vicii
.endif
	rts

display_keyboard:
.scope
.ifdef USE_VICII
	jsr process_skip
.endif
	
	ldx num_keys
	dex
loop:
.ifdef USE_VICII
	lda skip_key,x
	bne :+
.endif
	lda new_key_state,x
	cmp key_state,x
	beq :+
	sta key_state,x
	jsr display_key
:	dex
	bpl loop

	lda command
	bne no_key
	ldx key_index_help
	lda key_state,x
	beq no_help
	ldx help_count
	inx
	stx help_count
	cpx #HOLD_FRAMES
	bcc end
	lda #COMMAND_HELP
	sta command
	bne no_key
no_help:
	lda #0
	sta help_count
	ldx key_index_reset
	lda key_state,x
	beq no_key
	ldx reset_count
	inx
	stx reset_count
	cpx #HOLD_FRAMES
	bcc end
	lda #COMMAND_RESET_KEYBOARD
	sta command
no_key:
	lda #0
	sta reset_count
	sta help_count
end:
	rts
.endscope


read_keyboard:
.scope read_keyboard
.ifdef USE_VICII
	lda #$ff
	sta CIA1_PRA
	sta CIA1_PRB
	lda #$00
	sta CIA1_DDRA
	sta CIA1_DDRB
	lda CIA1_PRB
	eor #$ff
	ora port1
	sta port1
	lda CIA1_PRA
	eor #$ff
	sta port2
	lda #$ff
	sta CIA1_DDRA
	lda #$00
	sta CIA1_DDRB
.endif
.if .defined(__C64__)
    lda machine_type
    bpl init_bits
    lda #0
    beq init_end
init_bits:
    lda #$fe
init_end:
.elseif .defined(USE_PET) .or .defined(__MEGA65__)
	lda #0
.else
	lda #$fe
.endif
	ldx #0
byteloop:
select:
	sta KEYBOARD_SELECT
.ifdef USE_TED
	lda #$ff
	sta KEYBOARD_VALUE
.endif
value:
	lda KEYBOARD_VALUE
	eor #$ff
	tay
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
max_key_read:
	cpx #MAX_KEY_READ
	beq end_read
	txa
	lsr
	lsr
	lsr
	tay
.if .defined(__C64__)
    lda machine_type
    bpl next_bits
    tya
    bne next_end
next_bits:
    lda bitmask,y
    eor #$ff
next_end:
.elseif .not(.defined(USE_PET) .or .defined(__MEGA65__))
	lda bitmask,y
	eor #$ff
.endif
	bne byteloop

end_read:
.ifdef USE_VICII
.if .defined(__C64__)
    lda machine_type
    bpl :+
.endif
.if .defined(__C64__) .or .defined(__MEGA65__)
    lda $d60f
    and #$03
    beq :+
    ldy #0
    sty new_key_state + 2
    sty new_key_state + 7
    sty new_key_state + 6 * 8 + 4
.endif
.if .defined(__C64__)
:
.endif
	ldx restore_countdown
	beq :+
	dex
	stx restore_countdown
	txa
	ldx num_keys
	dex
	sta new_key_state,x
:
	lda #$ff
	sta CIA1_PRA
	sta CIA1_PRB
	lda #$00
	sta CIA1_DDRB
	sta CIA1_DDRA
	lda CIA1_PRB
	eor #$ff
	ora port1
	sta port1
	; TODO: if port 2 bit is set and key in that row is pressed, ignore that key's column (except for key itself)
.endif
	rts
.endscope

.if .defined(__C64__) .or .defined(__MEGA65__)
set_keyboard_registers:
    stx read_keyboard::select + 1
    sta read_keyboard::select + 2
    sty read_keyboard::value + 1
    sta read_keyboard::value + 2
    lda tmp1
    sta read_keyboard::max_key_read + 1
    rts

read_keyboard_mega65:
.scope
    ; Caps
    lda $d611
    and #%01000000
    sta new_key_state + 9 * 8
    lda $d60f
    tax
    ; Cursor Left
    and #$01
    sta new_key_state + 9 * 8 + 1
    txa
    ; Cursor up
    and #02
    sta new_key_state + 9 * 8 + 2
    rts
.endscope
.endif

.rodata

bitmask:
	.repeat 11, i
	.byte $01, $02, $04, $08, $10, $20, $40, $80
;	.byte $80, $40, $20, $10, $08, $04, $02, $01
	.endrep