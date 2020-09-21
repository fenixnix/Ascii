class_name Grid

var grids = []
var size = [1,1,1]
var endless = false

func _init(_size):
	size = _size
	grids.resize(DataSize())

func DataSize()->int:
	var dataSize = 1
	for s in size:
		dataSize*=s
	return int(dataSize)

func MaxSize():
	var tmp = 1
	for s in size:
		tmp = max(s,tmp)
	return tmp

func Fill(val):
	for i in len(grids):
		grids[i] = val.duplicate(true)

func Clear():
	Fill(null)

func RndIndex():
	return randi()%DataSize()

func CheckSet(val,loc):
	for i in len(loc):
		if loc[i]<0||loc[i]>size[i]:
			return
	Set(val,loc)

func Set(val,loc):
	grids[GetIndex(loc)] = val

func SetIndex(index,val):
	grids[index] = val

func Get(loc):
	return grids[GetIndex(loc)]

func CheckGet(loc):
	for i in len(loc):
		if loc[i]<0||loc[i]>size[i]:
			return
	return Get(loc)

func GetIndex(loc):
	var tmpLoc = []
	if endless:
		for i in len(loc):
			tmpLoc.append(posmod(loc[i],size[i]))
	else:
		for l in loc:
			tmpLoc.append(l)
	
	var tmp = 0
	for i in len(size):
		tmp += tmpLoc[i]*dSize(i)
	return tmp

func dSize(d)->int:
	var tmp = 1
	for i in d:
		tmp*=size[i]
	return int(tmp)

func GetLoc(index):
	var tmp = []
	for i in len(size):
		tmp.append(dLoc(i,index))
	return tmp

func dLoc(d:int,index:int):
	return index%dSize(d+1)/dSize(d)
