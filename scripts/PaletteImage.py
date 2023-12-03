from PIL import Image

class PaletteImage:
    def __init__(self, filename, palette):
        self.palette = palette
        self.filename = filename
        self.image = Image.open(filename)

    def get(self, x, y):
        pixel = self.image.getpixel((x, y))
        return self.palette[pixel[0] << 16 | pixel[1] << 8 | pixel[2]]
