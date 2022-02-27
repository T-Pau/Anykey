.autoimport +

.export display_help_screen, help_next, help_previous, display_main_screen, handle_help, current_page

.include "defines.inc"

.macpack utility

.code

display_help_screen:
    store_word saved_screen, ptr2
    store_word screen, ptr1
    lda saved_screen_size
    sta ptr3
    lda saved_screen_size + 1
    sta ptr3 + 1
    jsr memcpy
    ldx #0
    beq update_help_page

help_next:
    ldx current_page
    inx
    cpx help_count
    bne update_help_page
    ldx #0
    beq update_help_page

help_previous:
    ldx current_page
    dex
    bpl update_help_page
    ldx help_count
    dex
    bne update_help_page

update_help_page:
    stx current_page
    store_word help_pages, ptr2
    ldy #0
    lda (ptr2),y
    sta ptr3
    iny
    lda (ptr2),y
    sta ptr3 + 1
    txa
    asl
    tay
    lda (ptr3),y
    sta ptr1
    iny
    lda (ptr3),y
    sta ptr1 + 1
	store_word screen, ptr2
	jmp expand

display_main_screen:
    store_word screen, ptr2
    store_word saved_screen, ptr1
    lda saved_screen_size
    sta ptr3
    lda saved_screen_size + 1
    sta ptr3 + 1
    jsr memcpy
    ldx #$ff
    stx current_page
	rts

handle_help:
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

.bss

current_page:  ; $ff when not in help mode
    .res 1
