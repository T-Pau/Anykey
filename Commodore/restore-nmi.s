; this needs to be below $4000 to work in C128, so place it in unused screen space
.autoimport +

.include "platform.inc"

.code

.export init_restore_nmi
init_restore_nmi:
	lda NMIVec
	sta nmi_vector
	lda NMIVec + 1
	sta nmi_vector + 1
	ldx #<handle_nmi
	ldy #>handle_nmi
	stx NMIVec
	sty NMIVec + 1

    jmp init_restore


handle_nmi:
	pha
	jsr trigger_restore
	pla
	jmp (nmi_vector)
