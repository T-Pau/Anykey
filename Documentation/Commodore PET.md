# Anykey for Commodore PET

The programs are provided as disk images in `D64` and `D81` format, which also contain a loader program. They are also provided separately in `PRG` format.

## Supported Models

- Anykey PET 8k
- Anykey PET Full
  - any PET with at least 18k RAM

## Loading the Program

The disc image contains a BASIC loader that detects which machine it runs on and automatically loads the correct program. Load it with `LOAD"*",8` and start it with `RUN`.


## The Keyboard Window

The keys are displayed in the same layout as the physical keyboard.

Keys that are currently pressed are displayed inverted.

Keys that were previously pressed are displayed with a square frame. This helps detect dead keys. To reset the state of all keys to unpressed, hold `Clr/Home` for two seconds.


## Technical Limitations

If you press certain combinations of three keys, a fourth key will also appear pressed. This is because the three keys together create the same electrical connection the fourth key would.
