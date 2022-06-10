# Before Next Release
 
## VIC-20


## Other

- **C64/C128/VIC-20**: Fix for NTSC, SuperCPU.
- **C64/C128**: Ignore phantom keys when joystick 2 and certain keys are pressed at once.
- **C64/C128**: Test and improve phantom key suppression due to joysticks.

# Cleanup

- **Commodore**: Reduce usage of `.if .defined __TARGET__` in code.
- **Commodore**: Reduce code duplication.
- **Commodore**: Make sure no unused code gets pulled in.

# Later

- **Commodore**: display ignored keys (joystick &c) in PRESSED_COLOR
- **MEGA65**: High resolution native version.
- **Commodore**: Use proper tool for modifying directory listing.

# Incomplete Ports

## Maximite

- Support controller.
- Documentation
- Include in dist file.
- Support more keyboard layouts.
