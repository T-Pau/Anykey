;  irq.s -- Handle multiple raster IRQs.
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


.export init_irq, set_irq_table

.include "c64.inc"

; IRQ_DEBUG = 1

table = $c3

.bss

index:
	.res 1

table_length:
	.res 1

.code

init_irq:
	sei
	; disable cia 1 interrupts
	lda #$7f
    sta CIA1_ICR

	; enable rasterline irq
	ldx #1
    stx VIC_IMR

	lda #<irq_main
	sta $0314
	lda #>irq_main
	sta $0315
	cli
	rts

set_irq_table:
	stx table
	sty table + 1
	sta table_length
	lda #0
	sta index
	jmp setup_next_irq

irq_main:
.ifdef IRQ_DEBUG
	inc VIC_BORDERCOLOR
.endif
irq_jsr:
	jsr $0000
	jsr setup_next_irq
	; acknowledge irq
	lda #1
    sta VIC_IRR
.ifdef IRQ_DEBUG
	dec VIC_BORDERCOLOR
.endif
.if .defined(__C64__)
    jmp $ea81
.elseif .defined(__C128__)
	jmp $ff33
.else
.error "Target not supported"
.endif


setup_next_irq:
	ldy index

	; activate next entry
	lda (table),y
	sta VIC_HLINE
	iny
	lda (table),y
	beq high0
	lda VIC_CTRL1
	ora #$80
	sta VIC_CTRL1
	bne addr
high0:
	lda VIC_CTRL1
	and #$7f
	sta VIC_CTRL1
addr:
	iny
	lda (table),y
	sta irq_jsr + 1
	iny
	lda (table),y
	sta irq_jsr + 2

	iny
	cpy table_length
	bne :+
	ldy #0
:	sty index
	rts

