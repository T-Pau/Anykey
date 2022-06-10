.autoimport +

RESTORE_FRAMES = 10

.export init_restore
init_restore:
    lda #0
	sta restore_countdown
    rts

.export process_restore
process_restore:
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

.export trigger_restore
trigger_restore:
    lda #RESTORE_FRAMES
    sta restore_countdown
    rts

.bss

restore_countdown:
	.res 1
