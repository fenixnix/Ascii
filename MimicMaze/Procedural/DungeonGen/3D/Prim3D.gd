class_name Prim3D

var grid
var readyWall = []
var readyWallSrc = []
var maze = []

var currentPos = Vector2.ZERO

func Gen(loc,size)->Grid:
	grid = Maze3D.new(size)
	readyWall.clear()
	readyWallSrc.clear()
	maze.clear()
	currentPos = grid.GetIndex(loc)
	CheckAddNew(currentPos)
	while len(readyWall)>0:
		run(currentPos)
	return grid
	
func run(pos):
	maze.append(pos)
	CheckAddNew(pos)
	if len(readyWall)<=0:
		return
	var selIndex = randi()%len(readyWall)
	var dstIndex = readyWall[selIndex]
	var srcIndex = readyWallSrc[selIndex]
	grid.breakWall(srcIndex,dstIndex)
	readyWall.remove(selIndex)
	readyWallSrc.remove(selIndex)
	currentPos = dstIndex
	
func CheckAddNew(pos):
	for index in grid.aroundIndex(grid.GetLoc(pos)):
		if readyWall.has(index):
			continue
		if maze.has(index):
			continue
		readyWall.append(index)
		readyWallSrc.append(pos)
