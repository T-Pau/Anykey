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

The upper window shows the state of the keyboard.

The lower window shows the state of two joysticks connected to the controller ports.

To test other controller types or joystick adapters, please use the companion program [Joyride](https://github.com/T-Pau/Joyride) (currently only available on C64).

## Loading the Program

### Commodore 

The disc image contains a BASIC loader that detects which machine it runs on and automatically loads the correct program. For this to work on systems other than the C64, you need to load it with `LOAD"*",8`. Loading it with `LOAD"*",8,1` will not work. On C128 and MEGA65, the disk will autoboot: simply insert the disk and turn on the computer.

Since PET does not support loading programs to a different address, a separate disk image is provided. It also contains a BASIC loader that loads a version suitable for your model. 

### ZX Spectrum

The program is provided as a TAP tape image. Insert the tape and enter `LOAD ""` by pressing `j` and `Symbol-P` twice. Then press `Enter` and the play button on the tape deck.

## Keyboard

The keys are displayed in the same layout as the physical keyboard.

Keys that are currently pressed are displayed inverted.

Keys that were previously pressed are displayed in a different color. This helps detect dead keys. To reset the state of all keys to unpressed, hold `F5` for two seconds.

Since the PET only supports one color, previously pressed keys are displayed with a square frame.


## Joysticks

Joysticks contain a stick or d-pad with switches for the four cardinal directions and up to three buttons.

Pressed directions and buttons are displayed inverted.

On Commodore machines and MEGA65, buttons 2 and 3 bring an analog potentiometer to a low value by connecting its pin to +5V. This is not supported on Plus/4.
	

## Special Keys

`Shift Lock` and the left `Shift` key, and on Plus/4 also the right `Shift` key, appear as the same key to the computer and cannot be reliably distinguished on all computers. On Plus/4, both `Control` keys also appear as the same key.
	
The `Restore` key cannot be read directly. Anykey can detect when the key is pressed, but it can't detect for how long.

On MEGA65, when pressing `Cursor Up` or `Cursor Left`, `Right Shift` and the opposite cursor keys also appear pressed to software to maintain compatibility with C64. To avoid prematurely marking keys as pressed, these keys are disabled while `Cursor Up` or `Cursor Left is pressed. 

## MEGA65

When run in C64 mode on a MEGA65, Anykey will display and test the full MEGA65 keyboard.


## Commodore 128

When run in C64 mode on a C128, Anykey will display and test the full C128 keyboard.

The `40/80 Display` key cannot be read in C64 mode, therefore it is displayed grayed out. To test it, use the native version, Anykey 128.


Anykey will always display on the 40 columns (VIC) display, even if started from 80 columns mode.


## Commodore PET

Anykey PET requires at least 8k RAM. It supports both 40 and 80 column mode and all three types of keyboards: calculator style, with graphics symbols and big numeric keypad, and business keyboard with small numeric keypad.  

Since the PET does not support colors, keys that were previously pressed are displayed as squares.

Most keys are labeled with the symbol
they produce when pressed without shift.
Special keys are labeled with a
short description or graphics symbol,
depending on the space available:

- Clear/Home: `▘`, `CLR`
- Cursor Left/Right: `┳`, `<=>`
- Cursor Up/Down: `┣`, `U/D`
- Escape: `♣`, `ESC`
- Insert/Delete: `╳`, `DEL`
- Repeat: `π`
- Return: `RE`, `RET`
- Reverse On/Off: `◥`, `RV`
- Run/Stop: `◆`, `R/S`
- Shift: `○`, `SH`, `SHF`, `SHFT`
- Shift Lock: `●`, `SL`
- Tab: `TB`


## Technical Limitations

If you press certain combinations of three keys, a fourth key will also appear pressed. This is because the three keys together create the same electrical connection the fourth key would.                            

On C64 and C128, joysticks interfere with reading the keyboard. When a joystick is pressed, certain keys can't be read. These keys will be ignored while the joystick is pressed. If such a key was pressed before the joystick, it will remain pressed until the joystick is released. Auto fire might defeat this detection and result in phantom key presses.                              


# Building Anykey

See [BUILDING.md](BUILDING.md)
