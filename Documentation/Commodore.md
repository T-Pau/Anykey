# Anykey for Commodore 8-Bit Computers (and MEGA65)

There is a separate page for [Commodore PET](Commodore%20PET.md).

The programs are provided as disk images in `D64` and `D81` format, which also contain a loader program. They are also provided separately in `PRG` format.

## Supported Models

### Anykey C64
![](Anykey%20C64.png)
- Commodore 64
- Commodore 128 (in C64 mode)
- MEGA65 (in C64 mode)

### Anykey C128
![](Anykey%20C128.png)
- Commodore 128 (in C128 40 columns mode)

### Anykey MEGA65
![](Anykey%20MEGA65.png)
- MEGA65 (in native mode)
  
### Anykey Plus/4
![](Anykey%20Plus-4.png)
- Commodore Plus/4

## Loading the Program

The disc image contains a BASIC loader that detects which machine it runs on and automatically loads the correct program. For this to work on systems other than the C64, you need to load it with `LOAD"*",8` and start it with `RUN`. Loading it with `LOAD"*",8,1` will not work. On C128 and MEGA65, the disk will autoboot: simply insert the disk and turn on the computer.


## The Keyboard Window

The keys are displayed in the same layout as the physical keyboard.

Keys that are currently pressed are displayed inverted.

Keys that were previously pressed are displayed in a darker gray. This helps detect dead keys. To reset the state of all keys to unpressed, hold the key indicated on screen for two seconds. (`F5` on C64 and C128, `F13` on MEGA65, `F3` on Plus/4)


## The Joysticks Window

Joysticks contain a stick or d-pad with switches for the four cardinal directions and up to three buttons.

Pressed directions and buttons are displayed inverted.

Buttons 2 and 3 bring an analog potentiometer to a low value by connecting its pin to +5V. This is not supported on Plus/4.


## Technical Limitations

If you press certain combinations of three keys, a fourth key will also appear pressed. This is because the three keys together create the same electrical connection the fourth key would.

On C64 and C128, joysticks interfere with reading the keyboard. When a joystick is pressed, certain keys can't be read. These keys will be ignored while the joystick is pressed. If such a key was pressed before the joystick, it will remain pressed until the joystick is released. Auto fire might defeat this detection and result in phantom key presses.          
