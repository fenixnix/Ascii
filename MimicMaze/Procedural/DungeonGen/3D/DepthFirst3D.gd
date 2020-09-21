class_name DepthFirst3D

var maze:Grid
var visited = []
var readyStack = []
var curIndex:int = 0

func Gen(loc,size)->Grid:
	init(loc,size)
	while len(visited)<maze.DataSize():
		run()
	return maze

func init(loc,size):
	maze = Maze3D.new(size)
	visited.clear()
	readyStack.clear()
	curIndex = maze.GetIndex(loc)
	visited.append(curIndex)
	readyStack.push_back(curIndex)
	return maze

func run():
	var pos = maze.GetLoc(curIndex)
	var indexAround = aroundIndex(pos)
	if len(indexAround)>0:
		var randSelIndex = indexAround[randi()%len(indexAround)]
		if !readyStack.has(curIndex):
			readyStack.push_back(curIndex)
		maze.breakWall(curIndex,randSelIndex)
		visited.append(randSelIndex)
		curIndex = randSelIndex
	else:
		if len(readyStack)>0:
			curIndex = readyStack.pop_back()

func aroundIndex(xyz):
	var tmp = []
	for l in maze.aroundIndex(xyz):
		if !visited.has(l):
			tmp.append(l)
	return tmp
