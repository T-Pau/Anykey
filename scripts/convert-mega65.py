from PIL import Image

palette = {
    0xffffff: 0,
    0xA8A8A8: 1,
    0x545454: 2,
    0x000000: 3
}

def rgb2index(rgb):
    return palette[rgb[0] << 16 | rgb[1] << 8 | rgb[2] ]

image = Image.open("charset-16x16-2bit.png")

data = [b"", b""]

b = 0

for y in range(0, image.height // 16):
    for x in range(0, image.width // 16):
        for yy in range(0, 16):
            for xx in range(0, 16):
                value = rgb2index(image.getpixel((x * 16 + xx, y * 16 + yy)))
                if xx % 2 == 0:
                    b = value
                else:
                    b = b | (value << 4)
                    data[yy//8] += b.to_bytes(1, byteorder="little")

with open("charset-mega65.bin", "wb") as file:
    file.write(data[0])
    file.write(data[1])

# image = Image.open("keyboard-mega65-pressed.png")
