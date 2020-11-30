# Anykey

![Screenshot](screenshot.png)

This program displays the state of the keyboard and joysticks.

The upper window displays which keys are currently pressed.

The lower window shows the state of two joysticks connected to the controller ports.

To display other controller types or joystick adapters, please use the companion program [Joyride](https://github.com/T-Pau/Joyride).


## Technical Limitations

The `Restore` key cannot be read directly. Anykey can detect when the key is pressed, but it can't detect for how long.

Joysticks interfere with reading the keyboard. When a joystick is pressed, certain keys can't be read. These keys will be ignored while the joystick is pressed. If such a key was pressed before the joystick, it will remain pressed until the joystick is released. Auto fire might defeat this detection and result in phantom key presses.                              


# Building Anykey

Anykey is written in CC65 assembler. To build it, you need [cc65](https://cc65.github.io) and GNU make.

The graphics are drawn in [Affinity Photo](https://affinity.serif.com/en-gb/photo/) and converted with a custom, as yet unreleased, program and a [Python](https://www.python.org/) script. If you want to work on them, please contact me.

