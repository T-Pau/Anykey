; this needs to be below $4000 to work in C128, so place it in unused screen space
.autoimport +

.include "platform.inc"

RESTORE_FRAMES = 10

.code

.export init_restore
init_restore:
    lda #0
	sta restore_countdown

	lda NMIVec
	sta nmi_vector
	lda NMIVec + 1
	sta nmi_vector + 1
	ldx #<handle_nmi
	ldy #>handle_nmi
	stx NMIVec
	sty NMIVec + 1

	rts

.export read_restore
read_restore:
	ldx restore_countdown
	beq :+
	dex
	stx restore_countdown
	txa
	ldx num_keys
	dex
	sta new_key_state,x
:
    rts



handle_nmi:
	pha
	lda #RESTORE_FRAMES
	sta restore_countdown
	pla
	jmp (nmi_vector)


.bss

restore_countdown:
	.res 1
