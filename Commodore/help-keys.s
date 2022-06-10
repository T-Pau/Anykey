.include "platform.inc"

.autoimport +

.code

.export handle_help_keys
handle_help_keys:
.scope
    ldx help_keys
    stx ptr1
    ldx help_keys + 1
    stx ptr1 + 1
    ldy #0
loop:
    lda (ptr1),y
    cmp #$ff
    bne :+
   	lda #0
   	sta last_command
    rts
:   tax
    iny
    lda new_key_state,x
    beq :+
    lda (ptr1),y
    bne got_key
:   iny
    bne loop
got_key:
	cmp last_command
	beq end
	sta last_command
	sta command
end:
    rts
.endscope
