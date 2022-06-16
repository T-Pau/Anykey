# Building Anykey from Source

## Required Tools

### All Versions

You will need the following programs installed:

- GNU make
- [Python](https://www.python.org/)
  - [toml](https://github.com/uiri/toml) module
- [Perl](https://perl.org/)

Graphics are drawn in [Affinity Photo](https://affinity.serif.com/en-gb/photo/) and converted with the custom program [gfx-converter](https://github.com/T-Pau/gfx-converter).

### Commodore

The versions for Commodore 8-bt computers is written in [CC65](https://cc65.github.io) assembler.  Since CC65 doesn't support MEGA65 yet, you will have to use [my fork](https://github.com/dillof/cc65). 

You also need the `petcat` and `c1541` utilities from [Vice](http://vice-emu.sourceforge.net) and [ips_util](https://github.com/nleseul/ips_util).

### ZX Spectrum

The version for the ZX Spectrum is written in [Z88DK](https://z88dk.org/site/), a build from 2022 is required. 

You also need [tzxtools](https://shredzone.org/docs/tzxtools/).
