option explicit

const state.normal = 0
const state.checked = 1
const state.pressed = 2

const mapping.none = 0
const mapping.shift = 1
const mapping.control = 2
const mapping.numlock = 4

const modifier.shift = 136
const modifier.control = 34
const toggle.numlock = 2

const color.frame = gray(10)
const color.background = gray(24)
const color.label = gray(0)
const color.content = gray(4)
const color.pressed = gray(2)
const color.checked = gray(16)

dim key.frame(2) = (color.content, color.checked, color.pressed)
dim key.fill(2) = (color.background, color.background, color.pressed)
dim key.label(2) = (color.content, color.checked, color.background)

const special.reset = 0
const special.help = 1
const special.released = 0
const special.waiting = 1
const special.handled = 2
dim special.start(2)
dim integer special.state(2)


dim integer kb.x(128), kb.y(128), kb.width(128), kb.height(128), kb.state(128)
dim string kb.label(128) length 10
dim integer kb.length
dim integer mappings(256, 8, 3)
dim integer modifiers(8)
dim integer toggles(8)

const help.num_lines = 29
const help.max_pages = 16
const help.max_line_length = 44
const help.key.space = 0
const help.key.page_up = 1
const help.key.page_down = 2
const help.key.escape = 3
const help.key.num_keys = 4
dim integer help.key.code(3) = (32, 136, 137, 27)
dim integer help.key.pressed(4)
dim string help.title(help.max_pages) length help.max_line_length
dim string help.line(help.max_pages, help.num_lines) length help.max_line_length
dim integer help.num_pages
dim integer help.current_page

const xoff = 32
const yoff = 56
const grid = 16

#include "Font.inc"
#include "Font-Condensed.inc"

read_layout "us"
read_mapping "us"
help.load

main.display_screen

' save image "keyboard-us"

do
  pause 10000
loop



sub read_layout layout$
  local x, y, w, h, label$
  local integer index = 0
  open "Layout-" + layout$ + ".txt" for input as #1
  do
    input #1, x, y, label$, w, h

    if w > 0 and h > 0 then
      index = index + 1

      kb.x(index) = x
      kb.y(index) = y
      kb.width(index) = w
      kb.height(index) = h
      if label$ = "{128}" then
        kb.label$(index) = chr$(128)
      else if label$ = "{129}" then
        kb.label$(index) = chr$(129)
      else if label$ = "{130}" then
        kb.label$(index) = chr$(130)
      else if label$ = "{131}" then
        kb.label$(index) = chr$(131)
      else
        kb.label$(index) = label$
      end if
      kb.state(index) = state.normal
    end if
  loop until eof(#1)
  close #1
  kb.length = index
end sub


sub read_mapping layout$
  local integer code, i, j, k(24)

  open "Mapping-" + layout$ + ".txt" for input as #1
  for code = 0 to 7
    input #1, modifiers(code)
  next
  for code = 0 to 7
    input #1, toggles(code)
  next
  do
    input #1, code, k(0), k(1), k(2), k(3), k(4), k(5), k(6), k(7), k(8), k(9), k(10), k(11), k(12), k(13), k(14), k(15), k(16), k(17), k(18), k(19), k(20), k(21), k(22), k(23)
    for i = 0 to 7
      for j = 0 to 2
        mappings(code, i, j) = k(i * 3 + j)
      next j
    next i
  loop until eof(#1)
  close #1
end sub


sub press_key index
  kb.state(index) = state.pressed
  display_key index
end sub


sub release_key index
  kb.state(index) = state.checked
  display_key index
end sub


sub reset_keyboard
  local index
  for index = 1 to kb.length
    if kb.state(index) = state.checked then
      kb.state(index) = state.normal
      display_key index
    end if
  next
end sub


sub display_key index
  local x = kb.x(index) * grid + xoff
  local y = kb.y(index) * grid + yoff
  local w = kb.width(index) * grid
  local h = kb.height(index) * grid
  local label$ = kb.label$(index)
  local state = kb.state(index)

  local integer label_font
  if len(label$) = 1 then
  label_font = 8
  else
    label_font = 9
  end if
  rbox x+2, y+3, w-4, h-6, 3, key.frame(state), key.fill(state)
  text x+w/2, y+h/2, label$, "cm", label_font,, key.label(state), -1
end sub


function gray(intensity as integer)
  local value = (intensity << 3) or (intensity and 7)
  gray = rgb(value, value, value)
end function


sub main.frame
  local integer new_state(128)
  local integer i, mapping
  local f11_pressed, f12_pressed

  for i = 0 to 7
    if keydown(7) and (1 << i) then new_state(modifiers(i)) = state.pressed
  next
  for i = 0 to 7
    if keydown(8) and (1 << i) then new_state(toggles(i)) = state.pressed
  next
  
  mapping = 0
  if keydown(8) and toggle.numlock then mapping = mapping or mapping.numlock
  if keydown(7) and modifier.shift then mapping = mapping or mapping.shift
  if keydown(7) and modifier.control then mapping = mapping or mapping.control

  for i=1 to keydown(0)
    if keydown(i) > 0 then
      if keydown(i) = 155 or keydown(i) = 219 then f11_pressed = 1
      if keydown(i) = 156 or keydown(i) = 220 then f12_pressed = 1
      new_state(mappings(keydown(i), mapping, 0)) = state.pressed
      new_state(mappings(keydown(i), mapping, 1)) = state.pressed
      new_state(mappings(keydown(i), mapping, 2)) = state.pressed
    end if
  next

  if handle_special(special.reset, f11_pressed) then reset_keyboard
  if handle_special(special.help, f12_pressed) then help.display_screen

  for i = 1 to kb.length
    if new_state(i) = state.pressed and kb.state(i) <> state.pressed then
      press_key(i)
    else if new_state(i) <> state.pressed and kb.state(i) = state.pressed then
      release_key(i)
    end if
  next
end sub


function handle_special(which as integer, pressed as integer)
  handle_special = 0
  if pressed then
    select case special.state(which)
    case special.released
      special.start(which) = timer
      special.state(which) = special.waiting
    case special.waiting
      if special.start(which) + 2000 < timer then
        special.state(which) = special.handled
        handle_special = 1
      end if
    end select
  else
    special.state(which) = special.released
  end if 
end function


sub help.load
  local integer page = 0
  local string line_text
  local integer line

  open "help.txt" for input as #1
  do
    line input #1, help.title(page)
    for line = 0 to help.num_lines - 1
      line input #1, line_text
      if line_text = "---" then
        exit for
      end if
      help.line(page, line) = line_text
    next
    inc page
  loop until eof(#1)
  help.num_pages = page
  close #1
end sub


sub help.display_screen
  local integer j
  for j = 0 to help.key.num_keys - 1
    help.key.pressed(j) = 0
  next

  mode 1,16,color.background, help.frame
  cls color.frame
  display_logo 800-130, 600-40
  help.current_page = 0
  help.display_page  
  text 400, 600-80, "Space / Page Down: Next Page", "ct", 8,, color.label, -1
  text 400, 600-64, "Page Up: Previous Page", "ct", 8,, color.label, -1
  text 400, 600-48, "Escape: Return to Program", "ct", 8,, color.label, -1  
end sub


sub help.display_page
  local integer line_width = help.max_line_length * 16
  local integer x_offset = (800 - line_width) / 2
  box x_offset, 16, line_width, 16, 0, color.frame, color.frame
  text x_offset, 16, help.title(help.current_page), "lt", 8,, color.label, -1
  rbox x_offset - 16, yoff-grid, line_width + 32, help.num_lines*16, 8, color.background, color.background

  local integer line
  for line = 0 to help.num_lines - 1
    text x_offset, yoff + 16 * line, help.line(help.current_page, line), "lt", 8,, color.content, -1
  next
end sub


sub help.next_page
  inc help.current_page
  if help.current_page = help.num_pages then help.current_page = 0
  help.display_page
end sub


sub help.previous_page
  inc help.current_page, -1
  if help.current_page < 0 then help.current_page = help.num_pages - 1
  help.display_page
end sub


sub help.frame
  local pressed(help.key.num_keys)
  local integer i, j
  for i = 1 to keydown(0)
    for j = 0 to help.key.num_keys - 1
      if keydown(i) = help.key.code(j) then
        pressed(j) = 1
        if not help.key.pressed(j) then
          help.key.pressed(j) = 1
          select case j
          case help.key.space, help.key.page_down:
            help.next_page
          case help.key.page_up:
            help.previous_page
          case help.key.escape:
            main.display_screen
          end select
        end if
      end if
    next j
  next i
  for j = 0 to help.key.num_keys - 1
    if not pressed(j) then help.key.pressed(j) = 0
  next
end sub


sub main.display_screen
  mode 1,16,color.background, main.frame
  cls color.frame
  display_logo 800-130, 600-40

  rbox 16, yoff-grid, 800-32, 7.5*32, 8, color.background, color.background
  local integer index
  for index = 1 to kb.length
  display_key index
  next
  
  text 400, 600-64, "F11: Reset Keyboard  F12: Help", "ct", 8,, color.label, -1
  text 400, 600-48, "(Hold for 2 seconds.)", "ct", 8,, color.label, -1
  
end sub


sub display_logo x as integer, y as integer
  load png "icon.png", x, y
  text x+40, y+8, "T", "lt", 8,, color.label, -1
  text x+52, y+8, "'", "lt", 8,, color.label, -1
  text x+64, y+8, "PAU", "lt", 8,, color.label, -1
end sub
