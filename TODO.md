# Before Next Release
 
## VIC-20


## Other

- **Commodore**: Document joystick button 2/3 interaction with mouse/paddles.
- **C128/VIC-20**: Fix for NTSC.
- **C64**: Test fix for accelerators on Ultimate64.
- **C64/C128**: Ignore phantom keys when joystick 2 and certain keys are pressed at once.
- **C64/C128**: Test and improve phantom key suppression due to joysticks.

# Cleanup

- **Commodore**: Reduce usage of `.if .defined __TARGET__` in code.
- **Commodore**: Reduce code duplication.
- **Commodore**: Make sure no unused code gets pulled in.

# Later

- **Commodore**: Display ignored keys (joystick &c) in different color.
- **Commodore**: Only accept key presses if they are pressed for two consecutive frames (should suppress phantom presses caused by rapid joystick movements).
- **MEGA65**: High resolution native version.
- **C128**: 80 columns version.
- **Commodore**: Use proper tool for modifying directory listing.

# Incomplete Ports

## Maximite

- Support controller.
- Documentation
- Include in dist file.
- Support more keyboard layouts.
