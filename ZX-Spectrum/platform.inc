global charset, screen_main, colors_main, keys

PRESSED_COLOR =  $07 ; white on black
UNCHECKED_COLOR = $47 ; bright white on black
CHECKED_COLOR = $06 ; yellow on black

num_keys = 40

screen_size = 32 * 24
screen = $4000
color = screen + screen_size * 8
