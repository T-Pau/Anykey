;  start-pet.s -- Entry point of program, PET version.
;  Copyright (C) 2022 Dieter Baron
;
;  This file is part of Anykey, a keyboard test program.
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

.export start, process_keyboard
; TODO: dummy stubs for now
.export display_help_screen, help_next, help_previous, display_main_screen

.macpack utility

.include "defines.inc"

start:
	; TODO: check for 80 column mode, exit if not
	lda #12
	sta VIA_PCR
	
	copy_screen keyboard_pet_screen

	lda #0
	sta command
	sta last_command
	jsr init_keyboard	
	ldx #<keys_pet_address_low
	ldy #>keys_pet_address_low
	lda keys_pet_num_keys
	jsr set_keys_table
	jmp main_loop

process_keyboard:
	jsr read_keyboard
	jsr display_keyboard
	rts

; TODO: dummy stubs for now

display_help_screen:
	rts

help_next:
	rts

help_previous:
	rts

display_main_screen:
	rts
