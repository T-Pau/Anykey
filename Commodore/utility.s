;  utility.mac -- Utility macro package.
;  Copyright (C) Dieter Baron
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
;  THIS SOFTWARE IS PROVIDED BY THE AUTHORS "AS IS" AND ANY EXPRESS
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


.macro rl_expand_typed destination, source_c64, source_c128, source_mega65 {
    store_word destination_ptr, destination
    .if .defined(C64) {
        lda machine_type
        beq c64
        bpl c128
    }
    .if .defined(C64) || .defined(MEGA65) {
        store_word source_ptr, source_mega65
    }
    .if .defined(C64) {
        jmp copy
    c128:
    }
    .if .defined(C64) || .defined(C128) {
        store_word source_ptr, source_c128
    }
    .if .defined(C64) {
        jmp copy
    c64:
        store_word source_ptr, source_c64
    copy:
    }
    jsr rl_expand
}




;.public .macro copy_screen source {
;    store_word ptr1, source
;    store_word ptr2, screen
;    jsr expand
;}
