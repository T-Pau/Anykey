;  sprite.s -- Set coordinates for sprite.
;  Copyright (C) 2020 Dieter Baron
;
;  This file is part of Joyride, a controller test program for C64.
;  The authors can be contacted at <joyride@tpau.group>.
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


; set sprite A coordinates
.export sprite_x, sprite_y, set_sprite

.include "c64.inc"

.rodata

highbit:
	.byte $01, $fe,  $02, $fd,  $04, $fb,  $08, $f7
	.byte $10, $ef,  $20, $df,  $40, $bf,  $80, $7f

.bss

sprite_x:
	.res 2
sprite_y:
	.res 1

.code

set_sprite:
	asl
	tax

	lda VIC_SPR_HI_X
	and highbit + 1,x
	ldy sprite_x + 1
	beq set_high	
	ora highbit,x
set_high:
	sta VIC_SPR_HI_X

	lda sprite_x
	sta VIC_SPR0_X,x
	lda sprite_y
	sta VIC_SPR0_Y,x

	rts
