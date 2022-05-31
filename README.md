# Anykey

![Screenshot](screenshot.png)

This program monitors the keyboard and joysticks. It is useful to test hardware or to explore the key bindings of emulators.

It supports the following computers:

- Commodore 64
- Commodore 128 (128 mode in 40 columns or 64 mode)
- Commodore PET (8k required)
- Commodore Plus/4
- MEGA65 (native and 64 mode)
- Sinclair ZX Spectrum 48k
- Sinclair ZX Spectrum 48k+
- Sinclair ZX Spectrum 128k

The upper window shows the state of the keyboard.

If the computer has controller ports, the lower window shows the state of connected joysticks.

To test other controller types or joystick adapters, please use the companion program [Joyride](https://github.com/T-Pau/Joyride) (currently only available on C64).

For detailed usage instructions, see the documentation pages:

- [Commodore 8-Bit Computers](Documentation/Commodore.md)
- [Commodore PET](Documentation/Commodore%20PET.md)
- [Sinclair ZX Spectrum](Documentation/ZX%20Spectrum.md)


## Special Keys

`Shift Lock` and the left `Shift` key, and on Plus/4 also the right `Shift` key, appear as the same key to the computer and cannot be reliably distinguished on all computers. On Plus/4, both `Control` keys also appear as the same key.
	
The `Restore` key cannot be read directly. Anykey can detect when the key is pressed, but it can't detect for how long, is it assumes the key was released after a short while.

On MEGA65, when pressing `Cursor Up` or `Cursor Left`, `Right Shift` and the opposite cursor keys also appear pressed to software to maintain compatibility with C64. To avoid prematurely marking keys as pressed, these keys are disabled while `Cursor Up` or `Cursor Left` is pressed. 

## MEGA65

When run in C64 mode on a MEGA65, Anykey will display and test the full MEGA65 keyboard.


## Commodore 128

When run in C64 mode on a C128, Anykey will display and test the full C128 keyboard.

The `40/80 Display` key cannot be read in C64 mode, therefore it is displayed grayed out. To test it, use the native version, Anykey 128.


Anykey will always display on the 40 columns (VIC) display, even if started from 80 columns mode.


## Commodore PET

Anykey PET requires at least 8k RAM. It supports both 40 and 80 column mode and all three types of keyboards: calculator style, with graphics symbols and big numeric keypad, and business keyboard with small numeric keypad.  

Since the PET does not support colors, keys that were previously pressed are displayed as squares.


# Building Anykey

See [BUILDING.md](BUILDING.md)
