.pre_if .defined(PLATFORM_48K) || .defined(PLATFORM_PLUS) || .defined(PLATFORM_PLUS2)
.define USE_LOADING_SCREEN
.pre_end

.pre_if .defined(PLATFORM_PLUS2) || .defined(PLATFORM_NEXT) || .defined(PLATFORM_N_GO)
.define USE_JOYSTICKS
.pre_end

.pre_if .defined(PLATFORM_NEXT) || .defined(PLATFORM_N_GO)
.define USE_EXTENDED_KEYS
.define USE_JOYSTICK_3
.pre_end
