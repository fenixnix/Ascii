extends Grid2D

class_name Grid2DMaze

#Maze Function
func _init(w:int,h:int).(w,h):
	return ._init(w*2-1,h*2-1)

func MazeSize():
	return Vector2((width+1)/2,(height+1)/2)

func GetCell(x,y):
	return GetVal(x*2,y*2)

func SetCell(x:int,y:int,val):
	SetVal(x*2,y*2,val)

func FillCell(x:int, y:int, val):
	SetCell(x,y,val)
	SetVal(x*2-1,y*2,val)
	SetVal(x*2+1,y*2,val)
	SetVal(x*2,y*2-1,val)
	SetVal(x*2,y*2+1,val)

func FillDeadEndWhen(val,dst):
	for y in (height+1)/2:
		for x in (width+1)/2:
			if GetCell(x,y) == val && IsDeadEnd(x,y):
				FillCell(x,y,dst)

func MazeIndex(x,y):
	return x+y*(width+1)/2

func MazeVec2(index):
	var w = (width+1)/2
	return Vector2(index%w,index/w)

func CountDeadEndWhen(val):
	var cnt = 0
	for y in (height+1)/2:
		for x in (width+1)/2:
			if GetCell(x,y) == val && IsDeadEnd(x,y):
				cnt+=1
	return cnt

func GetAllDeadEndbyIndex(val):
	var tmp = []
	for y in MazeSize().y:
		for x in MazeSize().x:
			if IsDeadEnd(x,y)&&GetCell(x,y)==val:
				tmp.append(MazeIndex(x,y))
	return tmp

func IsDeadEnd(x,y):
	return CountWallAroundNot(x,y)>=3

func CountWallAroundNot(x,y,val = '.'):
	var sum = 0
	if UpWall(x,y) != val:
		sum += 1
	if LeftWall(x,y) != val:
		sum += 1
	if RightWall(x,y) != val:
		sum += 1
	if DownWall(x,y) != val:
		sum += 1
	return sum

func UpWall(x,y):
	return GetVal(x*2,y*2-1)

func LeftWall(x,y):
	return GetVal(x*2-1,y*2)

func RightWall(x,y):
	return GetVal(x*2+1,y*2)

func DownWall(x,y):
	return GetVal(x*2,y*2+1)

func FindMainPath():
	var deadEnd = GetAllDeadEndbyIndex('.')
	var astar = Grid2D_AStar.new()
	var maxLength = 0
	var maxPath = null
	astar.SetMaze(self)
	for i in len(deadEnd):
		for j in range(i+1,len(deadEnd)-1):
			var path = astar.CalcID(deadEnd[i],deadEnd[j])
			if len(path)>maxLength:
				maxLength = len(path)
				maxPath = path
	return maxPath

func GenRoomLevel():
	var roomDat = {}
	var mainPath = FindMainPath()
	var start
	if randi()%2 == 0:
		start = mainPath[0]
	else:
		start = mainPath[-1]
	var astar = Grid2D_AStar.new()
	astar.SetMaze(self)
	
	var lvs = []
	var mazeSize = MazeSize()
	for c in mazeSize.x*mazeSize.y:
		lvs.append(len(astar.CalcID(start.x+start.y*MazeSize().x,c)))
	return lvs
