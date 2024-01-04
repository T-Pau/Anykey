import sys


class AssemblerFormat:
    assemblers = {
        "xlr8": {
            "byte": ".data",
            "comment": "; ",
            "data_section": ".section data",
            "word": ".data",
            "object_start": " {",
            "object_end": "}"
        },
        "cc65": {
            "byte": ".byte",
            "comment": "; ",
            "data_section": ".section data",
            "export": ".export",
            "word": ".word",
            "object_start": ":",
        },
        "z88dk": {
            "byte": "byte",
            "comment": "; ",
            "data_section": "section data_user",
            "export": "public",
            "word": "word",
            "object_start": ":"
        }
    }

    def __init__(self, assembler):
        if assembler not in AssemblerFormat.assemblers:
            raise RuntimeError(f"unknown assembler '{assembler}'")
        assembler_format = AssemblerFormat.assemblers[assembler]

        self.byte = assembler_format["byte"]
        self.comment = assembler_format["comment"]
        self.data_section = assembler_format["data_section"]
        self.has_export = "export" in assembler_format
        if self.has_export:
            self.export = assembler_format["export"]
        self.word = assembler_format["word"]
        self.object_start = assembler_format["object_start"]
        self.has_object_end = "object_end" in assembler_format
        if self.has_object_end:
            self.object_end = assembler_format["object_end"]


class AssemblerOutput:
    def __init__(self, assembler_format: str, file):
        self.assembler = AssemblerFormat(assembler_format)
        self.file = file

    def byte(self, value):
        print(f"    {self.assembler.byte} {value}", file=self.file)

    def bytes(self, bytes_array):
        i = 0
        for byte in bytes_array:
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

    def public_symbol(self, name):
        self.empty_line()
        if self.assembler.has_export:
            print(f"{self.assembler.export} {name}", file=self.file)
            print(f"{name}{self.assembler.object_start}", file=self.file)
        else:
            print(f".public {name}{self.assembler.object_start}", file=self.file)

    def header(self, input_file):
        self.comment(f"This file is automatically created by {sys.argv[0]} from {input_file}.")
        self.comment(f"Do not edit.")
        self.empty_line()

    def private_symbol(self, name):
        self.empty_line()
        print(f"{name}{self.assembler.object_start}", file=self.file)

    def symbol_end(self):
        if self.assembler.has_object_end:
            print(self.assembler.object_end, file=self.file)

    def parts(self, name, parts):
        self.public_symbol(f"num_{name}")
        self.byte(len(parts))
        self.symbol_end()
        self.public_symbol(name)
        for i in range(len(parts)):
            self.word(f"{name}_{i}")
        self.symbol_end()
        for i in range(len(parts)):
            self.private_symbol(f"{name}_{i}")
            self.bytes(parts[i])
            self.symbol_end()

    def word(self, value):
        print(f"    {self.assembler.word} {value}", file=self.file)
