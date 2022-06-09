.include "vic20.inc"
USE_VIC = 1

MAX_NUM_KEYS = 64

USE_KEYBOARD_SELECT_BITMASK = 1

; TODO
KEYBOARD_SELECT = $0000
KEYBOARD_VALUE = $0000

FRAME_COLOR = 7 ; yellow
BACKGROUND_COLOR = 0 ; black
CONTENT_COLOR = 15 ; light yellow
LABEL_COLOR = 0 ; black
LOGO_COLOR = 0 ; black

PRESSED_COLOR = 9 ; gray
CHECKED_COLOR = 7 ; yellow
UNCHECKED_COLOR = 1; white

; TODO
SCREEN_TOP = 38

HOLD_FRAMES = 50

; TODO
tmp1 = $02
ptr1 = $fb
ptr2 = $fd
ptr3 = $c1

screen = $1000
color_ram = $9400
