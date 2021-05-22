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

const color.frame = gray(8)
const color.background = gray(24)
const color.label = gray(0)
const color.content = gray(4)
const color.pressed = gray(2)
const color.checked = gray(16)

dim key.frame(2) = (color.content, color.checked, color.pressed)
dim key.fill(2) = (color.background, color.background, color.pressed)
dim key.label(2) = (color.content, color.checked, color.background)

dim integer kb.x(128), kb.y(128), kb.width(128), kb.height(128), kb.state(128)
dim string kb.label(128) length 10
dim integer kb.length
dim integer mappings(256, 8, 3)
dim integer modifiers(8)
dim integer toggles(8)

const xoff = 32
const yoff = 64
const grid = 16

#include "Font.inc"
#include "Font-Condensed.inc"

print "Loading keyboard layout ... ";
read_layout "us"
read_mapping "us"
print "done."

mode 1,16,color.background, frame
cls

display_main_screen



save image "keyboard-us"

do
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
  rbox x+2, y+3, w-4, h-6, 5, key.frame(state), key.fill(state)
  text x+w/2, y+h/2, label$, "cm", label_font,, key.label(state), -1
end sub


function gray(intensity as integer)
  local value = (intensity << 3) or (intensity and 7)
  gray = rgb(value, value, value)
end function


sub frame
  local integer new_state(128)
  local integer i, mapping

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
      new_state(mappings(keydown(i), mapping, 0)) = state.pressed
      new_state(mappings(keydown(i), mapping, 1)) = state.pressed
      new_state(mappings(keydown(i), mapping, 2)) = state.pressed
    end if
  next

  for i = 1 to kb.length
    if new_state(i) = state.pressed and kb.state(i) <> state.pressed then
      press_key(i)
    else if new_state(i) <> state.pressed and kb.state(i) = state.pressed then
      release_key(i)
    end if
  next
end sub


sub display_main_screen
  cls color.frame
  rbox 16, 48, 800-32, 7.5*32, 5, color.background, color.background
  local integer index

  for index = 1 to kb.length
  display_key index
  next
  
  load png "icon.png", 800-(8.5*16), 600-40
  text 800-(6*16), 600-32, "T'PAU", "lt", 8,, color.label, -1
  text 32, 16, "Keyboard", "lt", 8,, color.label, -1
end sub
