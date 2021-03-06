# Anykey

![Screenshot](screenshot.png)

This program monitors the keyboard and joysticks. It supports Commodore 64, 128, and Plus/4.

The upper window shows the state of the keyboard.

The lower window shows the state of two joysticks connected to the controller ports.

To test other controller types or joystick adapters, please use the companion program [Joyride](https://github.com/T-Pau/Joyride).


## Loader

The disc image contains a BASIC loader that detects which machine it runs on and automatically loads the correct program. For this to work, you need to load it with `LOAD"*",8`. It will *not* work if you load it with `LAOD"*",8,1`.


## Keyboard

The keys are displayed in the same layout as the physical keyboard.

Keys that are currently pressed are displayed inverted.

Keys that were previously pressed are displayed in a lighter gray. This helps detect dead keys. To reset the state of all keys to unpressed, hold `F5` for two seconds.


## Joysticks

Joysticks contain a stick or d-pad with switches for the four cardinal directions and up to three buttons.

Pressed directions and buttons are displayed inverted.

Buttons 2 and 3 bring an analog potentiometer to a low value by connecting its pin to +5V. This is not supported on Plus/4.
	

## Special Keys

`Shift Lock` and the left `Shift` key, and on Plus/4 also the right `Shift` key, appear as the same key to the computer and cannot be reliably distinguished on all computers. On Plus/4, both `Control` keys also appear as the same key.
	
The `Restore` key cannot be read directly. Anykey can detect when the key is pressed, but it can't detect for how long.


## Commodore 128

When run in C64 mode on a C128, Anykey will display and test the full C128 keyboard.

The `40/80 Display` key cannot be read in C64 mode, therefore it is displayed grayed out. To test it, use the native version, Anykey 128.


## Technical Limitations

If you press certain combinations of three keys, a fourth key will also appear pressed. This is because the three keys together create the same electrical connection the fourth key would.                            

On C64 and C128, joysticks interfere with reading the keyboard. When a joystick is pressed, certain keys can't be read. These keys will be ignored while the joystick is pressed. If such a key was pressed before the joystick, it will remain pressed until the joystick is released. Auto fire might defeat this detection and result in phantom key presses.                              


# Building Anykey

Anykey is written in CC65 assembler. To build it, you need [cc65](https://cc65.github.io) and GNU make. You also need the `petcat` and `c1541` utilities from [Vice](http://vice-emu.sourceforge.net).

The graphics are drawn in [Affinity Photo](https://affinity.serif.com/en-gb/photo/) and converted with a custom, as yet unreleased, program and a [Python](https://www.python.org/) script. If you want to work on them, please contact me.
