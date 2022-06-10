import sys


class AssemblerFormat:
    assemblers = {
        "cc65": {
            "byte": ".byte",
            "comment": "; ",
            "data_section": ".rodata",
            "export": ".export",
            "word": ".word"
        },
        "z88dk": {
            "byte": "byte",
            "comment": "; ",
            "data_section": "section data_user",
            "export": "public",
            "word": "word"
        }
    }

    def __init__(self, assembler):
        if assembler not in AssemblerFormat.assemblers:
            raise RuntimeError(f"unknown assembler '{assembler}'")
        assembler_format = AssemblerFormat.assemblers[assembler]

        self.byte = assembler_format["byte"]
        self.comment = assembler_format["comment"]
        self.data_section = assembler_format["data_section"]
        self.export = assembler_format["export"]
        self.word = assembler_format["word"]


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

    def parts(self, name, parts):
        self.global_symbol(f"num_{name}")
        self.byte(len(parts))
        self.global_symbol(name)
        for i in range(len(parts)):
            self.word(f"{name}_{i}")
        for i in range(len(parts)):
            self.local_symbol(f"{name}_{i}")
            self.bytes(parts[i])

    def word(self, value):
        print(f"    {self.assembler.word} {value}", file=self.file)
