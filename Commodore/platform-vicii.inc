USE_VICII = 1
USE_SKIP = 1

.include "vic-ii.inc"

PRESSED_COLOR = COLOR_DARK_GRAY
CHECKED_COLOR = COLOR_MID_GRAY
UNCHECKED_COLOR = COLOR_BLACK

BACKGROUND_COLOR = COLOR_LIGHT_GRAY
FRAME_COLOR = COLOR_MID_GRAY
CONTENT_COLOR = COLOR_DARK_GRAY
LABEL_COLOR = COLOR_BLACK
LOGO_COLOR = COLOR_DARK_GRAY

SCREEN_TOP = 50

VIDEO_CURRENT_LINE = VIC_HLINE
VIDEO_BORDER_COLOR = VIC_BORDERCOLOR
VIDEO_BACKGROUND_COLOR = VIC_BG_COLOR0

KEYBOARD_SELECT = CIA1_PRA
KEYBOARD_VALUE = CIA1_PRB

MAX_NUM_KEYS = 91

KEY_INDEX_RESET = 6 ; F5
KEY_INDEX_HELP = 3 ; F7
HOLD_FRAMES = 50

; this needs to be below $4000 to work in C128, so place it in unused screen space
nmi_vector = $07e8

help_screen_title = screen + 1
help_screen_text = screen + 2 * 40

SCREEN_SIZE = 1000
