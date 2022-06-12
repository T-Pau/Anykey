# Before Next Release
 
- **C64**: Test fix for accelerators on Ultimate64.
- **C64/C128**: Test phantom key suppression due to joysticks.

# Cleanup

- **Commodore**: Reduce usage of `.if .defined __TARGET__` in code.
- **Commodore**: Reduce code duplication.
- **Commodore**: Make sure no unused code gets pulled in.

# Improvements

- **Commodore**: Display ignored keys (joystick &c) in different color.
- **C64/C128**: Ignore phantom keys when joystick 2 and certain keys are pressed at once.
- **MEGA65**: High resolution native version.
- **C128**: 80 columns version.
- **Commodore**: Use proper tool for modifying directory listing.

# Incomplete Ports

## Maximite

- Support controller.
- Documentation
- Include in dist file.
- Support more keyboard layouts.
