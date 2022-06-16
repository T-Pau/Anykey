# Anykey for Sinclair ZX-Spectrum

The programs are provided as tape images in `TAP` and `TZX` formats.

## Supported Models

There are five versions of Anykey for the various ZX Spectrum models to account for the different keyboard types:

### Anykey Spectrum 48k
![](Anykey%20Spectrum%2048k.png)
  - original ZX Spectrum 48k with rubber keyboard

### Anykey Spectrum 48k+ / 128k

![](Anykey%20Spectrum%2048k+%20128k.png)
- ZX Spectrum 48k+
- ZX Spectrum 128k

### Anykey Spectrum +2 / +3
![](Anykey%20Spectrum%20+2%20+3.png)

- ZX Spectrum +2 (gray model, made by Sinclair)
- ZX Spectrum +2A (black model, made by Amstrad)
- ZX Spectrum +3

### Anykey Spectrum Next
![](Anykey%20Spectrum%20Next.png)

- ZX Spectrum Next

### Anykey Spectrum N-Go

![](Anykey%20Spectrum%20N-Go.png)
- N-Go (ZX Spectrum Next clone)


## Loading the Program

Insert the tape and enter `LOAD ""` by pressing `J` and `Symbol-P` twice. Then press `Enter` and the play button on the tape deck.


## The Keyboard Window

The keys are displayed in the same layout as the physical keyboard.

Keys that are currently pressed are displayed inverted.

Keys that were previously pressed are displayed in yellow. This helps detect dead keys. To reset the state of all keys to unpressed, hold `9` for two seconds.


## The Joysticks Window

Joysticks contain a stick or d-pad with switches for the four cardinal directions and a button.

Pressed directions and buttons are displayed inverted.

The +2 and +3 has two joystick ports, Sinclair 1 and Sinclair 2. Joystick movement is seen by the computer as key presses. Sinclair 1 uses the keys 6-0, Sinclair 2 the keys 1-5.

On Next and N-Go, the three joysticks displayed are Sinclair 1, Sinclair 2, and Kempston. There are two joystick physical ports. The user can configure each of these as any of the three joysticks.

Anykey doesn't know which are in use, so it always displays all three.

## Special Keys

On 48k+, 128k, +2, and +3 models all keys except for digits, letters, `Space`, `Enter`, `Caps Shift` and `Symbol Shift` are read by the computer as two key presses.

The computer can't tell if such a key or the two corresponding keys are pressed, so Anykey displays all three as pressed.

For best results, test the normal keys first.


## Technical Limitations

If you press certain combinations of three keys, a fourth key will also appear pressed. This is because the three keys together create the same electrical connection the fourth key would.
