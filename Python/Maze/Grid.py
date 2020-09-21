class Grid:
    size = []
    datas = []
    def __init__(self,_size):
        self.size = _size
        dataSize = 1
        for i in range(len(_size)):
            dataSize*=_size[i]
        defaultData = '#'*len(_size)
        self.datas = defaultData*dataSize

    def Fill(self,val):
        for i in range(len(self.datas)):
            self.datas[i] = val
    
    def Print(self):
        print(self.datas)
