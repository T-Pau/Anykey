.if .defined(__C64__)
.include "platform-c64.inc"
.elseif .defined(__C128__)
.include "platform-c128.inc"
.elseif .defined(__MEGA65__)
.include "platform-mega65.inc"
.elseif .defined(__PET__)
.include "platform-pet.inc"
.elseif .defined(__PLUS4__)
.include "platform-plus4.inc"
.elseif .defined(__VIC20__)
.include "platform-vic20.inc"
.else
.error "Target not supported"
.endif
