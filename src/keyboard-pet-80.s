.export keyboard_pet_business_80_screen, keyboard_pet_calculator_80_screen

.macpack utility

.include "defines.inc"

.rodata

keyboard_pet_business_80_screen:
	.incbin "keyboard-pet-business.bin"

keyboard_pet_calculator_80_screen:
	.incbin "keyboard-pet-graphics.bin"
