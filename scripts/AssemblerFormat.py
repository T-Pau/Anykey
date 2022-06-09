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
