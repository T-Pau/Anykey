from PIL import Image


class NCM:
    def __init__(self, filename, palette, char_width=16, char_height=8, fill_color=0):
        # TODO: check char_width <= 16, char_height <= 8
        # TODO: check image.width % char_width == 0, same for height
        self.image = Image.open(filename)
        self.palette = palette
        self.fill_color = fill_color
        self.char_width = char_width
        self.char_height = char_height
        self.width = self.image.width // char_width
        self.height = self.image.height // char_height

    def get(self, x, y):
        data = b""
        for yy in range(0, 8):
            b = 0
            for xx in range(0, 16):
                color = self.fill_color
                if xx < self.char_width and yy < self.char_height:
                    color = self.rgb2index(self.image.getpixel((x * self.char_width + xx, y * self.char_height + yy)))
                if xx % 2 == 0:
                    b = color
                else:
                    b = b | (color << 4)
                    data += b.to_bytes(1, byteorder="little")
        return data

    def rgb2index(self, rgb):
        return self.palette[rgb[0] << 16 | rgb[1] << 8 | rgb[2]]
