;  display_key.s -- Display state of key
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

.export display_key

.include "anykey.inc"

.macpack utility

COLOR_RAM_OFFSET = color_ram - screen
PRESSED_COLOR = COLOR_GRAY1
CHECKED_COLOR = COLOR_GRAY2
 
.macro key x0, y0, size
	.word screen + x0 + y0 * 40 + 81
	.if (size = 2)
	.word display_key_2
	.elseif (size = 3)
	.word display_key_3
	.elseif (size = 4)
	.word display_key_4
	.elseif (size = 17)
	.word display_key_17
	.elseif (size = 23)
	.word display_key_2_3
	.else
	.error invalid key size
	.endif
.endmacro

.macro set_color
.scope
	add_word ptr1, COLOR_RAM_OFFSET
	lda #CHECKED_COLOR
	ldy state
	beq released
	lda #PRESSED_COLOR
	ldy #0
released:
.endscope
.endmacro

.rodata

keys:
	key 30, 0, 2 ; insert / delete
	key 28, 4, 4 ; return
	key 30, 6, 2 ; cursor left / right
	key 35, 6, 3 ; F7
	key 35, 0, 3 ; F1
	key 35, 2, 3 ; F3
	key 35, 4, 3 ; F5
	key 28, 6, 2 ; cursor up / down

	key  6, 0, 2 ; 3
	key  5, 2, 2 ; W
	key  4, 4, 2 ; A
	key  8, 0, 2 ; 4
	key  5, 6, 2 ; Z
	key  6, 4, 2 ; S
	key  7, 2, 2 ; E
	key  2, 4, 23 ; shift lock + left shift

	key 10, 0, 2 ; 5
	key  9, 2, 2 ; R
	key  8, 4, 2 ; D
	key 12, 0, 2 ; 6
	key  9, 6, 2 ; C
	key 10, 4, 2 ; F
	key 11, 2, 2 ; T
	key  7, 6, 2 ; X

	key 14, 0, 2 ; 7
	key 13, 2, 2 ; Y
	key 12, 4, 2 ; G
	key 16, 0, 2 ; 8
	key 13, 6, 2 ; B
	key 14, 4, 2 ; H
	key 15, 2, 2 ; U
	key 11, 6, 2 ; V

	key 18, 0, 2 ; 9
	key 17, 2, 2 ; I
	key 16, 4, 2 ; J
	key 20, 0, 2 ; 0
	key 17, 6, 2 ; M
	key 18, 4, 2 ; K
	key 19, 2, 2 ; O
	key 15, 6, 2 ; N

	key 22, 0, 2 ; +
	key 21, 2, 2 ; P
	key 20, 4, 2 ; L
	key 24, 0, 2 ; -
	key 21, 6, 2 ; .
	key 22, 4, 2 ; :
	key 23, 2, 2 ; @
	key 19, 6, 2 ; ,

	key 26, 0, 2 ; £
	key 25, 2, 2 ; *
	key 24, 4, 2 ; ;
	key 28, 0, 2 ; clear / home
	key 25, 6, 3 ; right shift
	key 26, 4, 2 ; =
	key 27, 2, 2 ; ^
	key 23, 6, 2 ; /

	key 2, 0, 2 ; 1
	key 0, 0, 2 ; <-
	key 0, 2, 3 ; control
	key 4, 0, 2 ; 2
	key 6, 8, 17; space
	key 0, 6, 2 ; C=
	key 3, 2, 2 ; Q
	key 0, 4, 2 ; run / stop

	key 29, 2, 3 ; restore

.bss

state:
	.res 1

.code

; display key x pressed a
; x is not disturbed

display_key:
	cmp #0
	beq :+
	lda #$80
:	sta state
	txa
	asl
	bmi restore
	asl
	tay
	lda keys,y
	sta ptr1
	lda keys + 1,y
	sta ptr1 + 1
	lda keys + 2,y
	sta jump + 1
	lda keys + 3,y
	sta jump + 2
	ldy #0
jump:
	jmp $1000
restore:
	lda keys + 256
	sta ptr1
	lda keys + 256 + 1
	sta ptr1 + 1
	ldy #0
	jmp display_key_3


display_key_2:
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y

	ldy #40
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y

	set_color
	sta (ptr1),y
	iny
	sta (ptr1),y
	ldy #40
	sta (ptr1),y
	iny
	sta (ptr1),y
	
	rts


display_key_3:
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y

	ldy #40
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	
	set_color
	sta (ptr1),y
	iny
	sta (ptr1),y
	iny
	sta (ptr1),y
	ldy #40
	sta (ptr1),y
	iny
	sta (ptr1),y
	iny
	sta (ptr1),y

	rts


display_key_4:
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y

	ldy #40
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y

	set_color
	sta (ptr1),y
	iny
	sta (ptr1),y
	iny
	sta (ptr1),y
	iny
	sta (ptr1),y
	ldy #40
	sta (ptr1),y
	iny
	sta (ptr1),y
	iny
	sta (ptr1),y
	iny
	sta (ptr1),y

	rts


display_key_2_3:
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y

	ldy #40
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y

	ldy #80
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y

	ldy #120
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y

	set_color
	sta (ptr1),y
	iny
	sta (ptr1),y
	ldy #40
	sta (ptr1),y
	iny
	sta (ptr1),y
	ldy #80
	sta (ptr1),y
	iny
	sta (ptr1),y
	iny
	sta (ptr1),y
	ldy #120
	sta (ptr1),y
	iny
	sta (ptr1),y
	iny
	sta (ptr1),y

	rts


display_key_17:
	ldy #16
:	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	dey
	bpl :-

	ldy #40
:	lda (ptr1),y
	and #$7f
	ora state
	sta (ptr1),y
	iny
	cpy #40 + 17
	bne :-

	set_color
	ldy #16
:	sta (ptr1),y
	dey
	bpl :-

	ldy #40
:	sta (ptr1),y
	iny
	cpy #40 + 17
	bne :-
	
	rts
