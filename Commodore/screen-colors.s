.section data

.public main_color_64 {
    rl_encode 40 * 2, FRAME_COLOR
    rl_encode 40 * 10, UNCHECKED_COLOR
    rl_encode 40 * 4, FRAME_COLOR
    .repeat 5 {
        rl_encode 4, FRAME_COLOR
        rl_encode 32, CONTENT_COLOR
        rl_encode 4, FRAME_COLOR
    }
    rl_encode 40 * 4, FRAME_COLOR
    rl_end
}

.public main_color_128 {
    rl_encode 40 * 2, FRAME_COLOR
    .if .defined(C64) {
        .repeat 2 {
            rl_encode 16, UNCHECKED_COLOR
            rl_encode 2, PRESSED_COLOR
            rl_encode 22, UNCHECKED_COLOR
        }
    }
    .else {
        rl_encode 40 * 2, UNCHECKED_COLOR
    }
    rl_encode 40 * 10, UNCHECKED_COLOR
    rl_encode 40 * 3, FRAME_COLOR
    .repeat 5 {
        rl_encode 5, FRAME_COLOR
        rl_encode 30, CONTENT_COLOR
        rl_encode 5, FRAME_COLOR
    }
    rl_encode 40 * 3, FRAME_COLOR
    rl_end
}

.public main_color_mega65_c64 {
    rl_encode 40 * 2, FRAME_COLOR
    .repeat 12 {
        rl_encode 3, FRAME_COLOR
        rl_encode 34, UNCHECKED_COLOR
        rl_encode 3, FRAME_COLOR
    }
    rl_encode 40 * 3, FRAME_COLOR
    .repeat 5 {
        rl_encode 5, FRAME_COLOR
        rl_encode 34, CONTENT_COLOR
        rl_encode 5 , FRAME_COLOR
    }
    rl_encode 40 * 3, FRAME_COLOR
    rl_end
}
