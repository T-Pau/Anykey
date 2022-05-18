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

; IRQ_DEBUG = 1

.if .defined(__C64__)
.include "c64.inc"
END_OF_IRQ = $ea81
USE_VICII = 1

.elseif .defined(__C128__)
.include "c128.inc"
END_OF_IRQ = $ff33
USE_VICII = 1

.elseif .defined(__MEGA65__)
.include "mega65.inc"
; TODO: find in ROM?
.code
END_OF_IRQ:
    pla
    tay
    pla
    tax
    pla
    rti
USE_VICII = 1

.elseif .defined(__PLUS4__)
.include "plus4.inc"
END_OF_IRQ = $fcbe
USE_TED = 1

.else
.error "Target not supported"
.endif

.if .defined(USE_VICII)
table = $c3
BORDERCOLOR = VIC_BORDERCOLOR
HLINE_LOW = VIC_HLINE
HLINE_HIGH = VIC_CTRL1
HLINE_BIT8 = $80
IRR = VIC_IRR
IMR = VIC_IMR
IRQ_RASTER = 1

.elseif .defined(USE_TED)
table = $e7
BORDERCOLOR = TED_BORDERCOLOR
HLINE_LOW = $FF0B
HLINE_HIGH = $FF0A
HLINE_BIT8 = 1
IRR = $FF09
IMR = $FF0A
IRQ_RASTER = 2
.endif

.bss

index:
	.res 1

table_length:
	.res 1

.code

init_irq:
	sei
.if .defined(USE_VICII)
	; disable cia 1 interrupts
	lda #$7f
    sta CIA1_ICR
.endif

	; enable rasterline irq
	ldx #IRQ_RASTER
    stx IMR

	lda #<irq_main
	sta IRQVec
	lda #>irq_main
	sta IRQVec + 1
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
	inc BORDERCOLOR
.endif
.ifdef __C128__
	lda #$0e
	sta MMU_CR
.endif
irq_jsr:
	jsr $0000
	jsr setup_next_irq
	; acknowledge irq
	lda #IRQ_RASTER
    sta IRR
.ifdef IRQ_DEBUG
	dec BORDERCOLOR
.endif
    jmp END_OF_IRQ


setup_next_irq:
	ldy index

	; activate next entry
	lda (table),y
	sta HLINE_LOW
	iny
	lda (table),y
	beq high0
	lda HLINE_HIGH
	ora #HLINE_BIT8
	sta HLINE_LOW
	bne addr
high0:
	lda HLINE_HIGH
	and #HLINE_BIT8 ^ $ff
	sta HLINE_HIGH
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
