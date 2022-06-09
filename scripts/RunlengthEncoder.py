class RunlengthEncoder:
    def __init__(self):
        self.compressed = b""
        self.code_runlength = 0xff
        self.code_skip = 0xfe
        self.last_byte = -1
        self.runlength = 0

    def add_bytes(self, bytes):
        for byte in bytes:
            self.add(byte)

    def add(self, byte):
        if byte != self.last_byte:
            self.end_run()
            self.last_byte = byte
            self.runlength = 1
        else:
            self.runlength += 1
            if self.runlength == 255:
                self.end_run()

    def skip(self, amount):
        if amount == 0:
            return
        self.end_run()
        while amount > 255:
            self.output(self.code_skip)
            self.output(255)
            amount -= 255
        if amount > 0:
            self.output(self.code_skip)
            self.output(amount)

    def end(self):
        self.end_run()
        self.output(self.code_runlength)
        self.output(0)
        result = self.compressed
        self.compressed = b""
        return result

    def end_run(self):
        if self.runlength > 2 or self.last_byte == self.code_runlength or self.last_byte == self.code_skip:
            self.output(self.code_runlength)
            self.output(self.runlength)
            self.output(self.last_byte)
        else:
            for i in range(self.runlength):
                self.output(self.last_byte)
        self.last_byte = -1
        self.runlength = 0

    def output(self, byte):
        if type(byte) is bytes:
            self.compressed += byte
        else:
            self.compressed += byte.to_bytes(1, byteorder="little")
