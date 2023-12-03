.include "plus4.inc"

USE_TED = 1
USE_KEYBOARD_SELECT_BITMASK = 1

.include "ted.inc"

.section zero_page

.global tmp1 .reserve 1
.global ptr1 .reserve 2
.global ptr2 .reserve 2
.global ptr3 .reserve 2

PRESSED_COLOR = ($30 | COLOR_WHITE)
CHECKED_COLOR = ($40 | COLOR_WHITE)
UNCHECKED_COLOR = ($10 | COLOR_BLACK)

BACKGROUND_COLOR = ($60 | COLOR_WHITE)
FRAME_COLOR = ($50 | COLOR_WHITE)
CONTENT_COLOR = ($30 | COLOR_WHITE)
LABEL_COLOR = COLOR_BLACK
; LOGO_COLOR = ($20 | COLOR_WHITE)

SCREEN_TOP = 3 ; TODO

charset = $8000
charset_keyboard_top = charset + $800
charset_keyboard_bottom = charset_keyboard_top + $800

screen = $0c00
color_ram = $0800

help_screen_title = screen + 1
help_screen_text = screen + 2 * 40

VIDEO_CURRENT_LINE = TED_VLINELO
VIDEO_BORDER_COLOR = TED_BORDERCOLOR
VIDEO_BACKGROUND_COLOR = TED_BGCOLOR

KEYBOARD_SELECT = $FD30
KEYBOARD_VALUE = TED_KBD

MAX_NUM_KEYS = 64

KEY_INDEX_RESET = 6 ; F3
KEY_INDEX_HELP = 3 ; Help
HOLD_FRAMES = 50

SCREEN_SIZE = 1000
