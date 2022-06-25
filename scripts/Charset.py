class Charset:
    def __init__(self, size, empty):
        self.by_index = dict()
        self.by_value = dict()
        self.next_index = 0
        self.size = size
        self.empty = empty

    def add(self, value):
        if value in self.by_value:
            return self.by_value[value]
        else:
            index = self.get_next_index()
            self.by_value[value] = index
            self.by_index[index] = value
            return index

    def add_with_index(self, value, index):
        if index in self.by_index:
            raise RuntimeError(f"character {index} already set")
        else:
            self.by_index[index] = value
            self.by_value[value] = index

    def get_next_index(self):
        while self.next_index in self.by_index:
            self.next_index += 1
            if self.next_index >= self.size:
                raise RuntimeError("out of characters")
        return self.next_index

    def get_values(self, index):
        if index in self.by_index:
            return self.by_index[index]
        else:
            return self.empty
