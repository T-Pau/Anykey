import sys

import AssemblerFormat


class AssemblerOutput:
    def __init__(self, assembler: AssemblerFormat.AssemblerFormat, file):
        self.assembler = assembler
        self.file = file

    def byte(self, value):
        print(f"    {self.assembler.byte} {value}", file=self.file)

    def bytes(self, bytes):
        i = 0
        for byte in bytes:
            if i == 0:
                self.file.write(f"    {self.assembler.byte} ")
            else:
                self.file.write(", ")
            self.file.write(f'${byte:02x}')
            i += 1
            if i == 8:
                self.file.write("\n")
                i = 0
        if i > 0:
            self.file.write("\n")

    def comment(self, comment):
        print(f"{self.assembler.comment} {comment}", file=self.file)

    def data_section(self):
        print(f"{self.assembler.data_section}", file=self.file)

    def empty_line(self):
        print("", file=self.file)

    def global_symbol(self, name):
        self.empty_line()
        print(f"{self.assembler.export} {name}", file=self.file)
        print(f"{name}:", file=self.file)

    def header(self, input_file):
        self.comment(f"This file is automatically created by {sys.argv[0]} from {input_file}.")
        self.comment(f"Do not edit.")
        self.empty_line()

    def local_symbol(self, name):
        self.empty_line()
        print(f"{name}:", file=self.file)

    def word(self, value):
        print(f"    {self.assembler.word} {value}", file=self.file)
