.pre_if .defined(PLATFORM_NEXT) || .defined(PLATFORM_N_GO)
.define USE_EXTENDED_KEYS
.pre_else
.define USE_LOADING_SCREEN
.pre_end
