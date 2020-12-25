;  keyboard.s -- Process and display keyboard state
;  Copyright (C) 2020 Dieter Baron
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

.export init_keyboard, display_keyboard, reset_keyboard, read_keyboard
.export key_state, new_key_state, bitmask

.include "defines.inc"

.macpack utility

HOLD_FRAMES = 50

.bss

key_state:
	.res MAX_NUM_KEYS

new_key_state:
	.res MAX_NUM_KEYS

f5_count:
	.res 1
f7_count:
	.res 1

.code

init_keyboard:
	ldx #MAX_NUM_KEYS
	lda #0
:	sta key_state,x
	sta new_key_state,x
	dex
	bpl :-
	sta f5_count
	sta f7_count
.ifdef USE_VICII
	jsr init_keyboard_vicii
.endif
	rts

reset_keyboard:
.scope
	lda keyboard_height
	cmp #12
	beq low
	store_word 40 * 12, ptr3
	bne both
low:
	store_word 40 * 10, ptr3
both:
	store_word color_ram + 40 * 2, ptr2
	ldy #0
	ldx ptr3 + 1
	beq partial
loop:
	lda (ptr2),y
.ifdef USE_VICII
	and #$0f
.endif
	cmp #CHECKED_COLOR
	bne :+
	lda #UNCHECKED_COLOR
	sta (ptr2),y
:	iny
	bne loop
	inc ptr2 + 1
	dex
	bne loop

partial:
	ldx ptr3
	beq end
partial_loop:
	lda (ptr2),y
	and #$0f
	cmp #CHECKED_COLOR
	bne :+
	lda #UNCHECKED_COLOR
	sta (ptr2),y
:	iny
	dex
	bne partial_loop
end:
	rts
.endscope


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
	lda key_state + KEY_INDEX_HELP
	beq no_f7
	ldx f7_count
	inx
	stx f7_count
	cpx #HOLD_FRAMES
	bcc end
	lda #COMMAND_HELP
	sta command
	bne no_key
no_f7:
	lda #0
	sta f7_count
	lda key_state + KEY_INDEX_RESET
	beq no_key
	ldx f5_count
	inx
	stx f5_count
	cpx #HOLD_FRAMES
	bcc end
	lda #COMMAND_RESET_KEYBOARD
	sta command
no_key:
	lda #0
	sta f5_count
	sta f7_count
end:
	rts
.endscope


read_keyboard:
.scope
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
	lda #$fe
	ldx #0
byteloop:
	sta KEYBOARD_SELECT
.ifdef USE_TED
	lda #$ff
	sta KEYBOARD_VALUE
.endif
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
	cpx #64
	beq end_read
	txa
	lsr
	lsr
	lsr
	tay
	lda bitmask,y
	eor #$ff
	bne byteloop

end_read:
.ifdef USE_VICII
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

.rodata

bitmask:
	.repeat 11, i
	.byte $01, $02, $04, $08, $10, $20, $40, $80
;	.byte $80, $40, $20, $10, $08, $04, $02, $01
	.endrep
