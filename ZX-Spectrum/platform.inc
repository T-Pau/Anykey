global charset, screen_main, colors_main, keys_48k

screen_size = 32 * 24
screen = $4000
color = screen + screen_size * 8

KEYBOARD_OFFSET = 32 * 4 + 5
KEYBOARD_SIZE = 32 * 7 + 22

PRESSED_COLOR =  $07 ; white on black
UNCHECKED_COLOR = $47 ; bright white on black
CHECKED_COLOR = $06 ; yellow on black

num_keys = 40

KEY_INDEX_RESET = 21
KEY_INDEX_HELP = 20
KEY_INDEX_NEXT = 35
KEY_INDEX_PREVIOUS = 25
KEY_INDEX_RETURN = 20

PRESS_DURATION = 250
