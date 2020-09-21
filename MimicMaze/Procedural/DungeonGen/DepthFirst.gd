extends Node

class_name DepthFirst

var maze = []
var visited = []
var readyStack = []

var width:int = 1
var height:int = 1
var datW:int = 1
var datH:int = 1
var curIndex:int = 0

func Gen(x,y,_width,_height):
	width = _width
	height = _height
	datW = width*2-1
	datH = height*2-1
	visited.clear()
	readyStack.clear()
	maze.resize(datW*datH)
	fill()
	curIndex = pos2Index(x,y)
	visited.append(curIndex)
	readyStack.push_back(curIndex)
	while len(visited)<width*height:
		run()
	return {"grid":maze,"width":width,"height":height}

func Print():
	for y in datH:
		var line = ""
		for x in datW:
			line += maze[x + y*datW]
		print(line)
	#print(visited)

func fill():
	for i in maze.size():
		maze[i] = "#"

func run():
	var pos = index2Pos(curIndex)
	var indexAround = aroundIndex(pos[0],pos[1])
	if len(indexAround)>0:
		var randSelIndex = indexAround[randi()%len(indexAround)]
		if !readyStack.has(curIndex):
			readyStack.push_back(curIndex)
		breakWall(curIndex,randSelIndex)
		visited.append(randSelIndex)
		curIndex = randSelIndex
	else:
		if len(readyStack)>0:
			curIndex = readyStack.pop_back()

func breakWall(from, to):
	var fromPos = index2Pos(from)
	var toPos = index2Pos(to)
	maze[fromPos[0]*2+fromPos[1]*2*datW] = '.'
	maze[toPos[0]*2+toPos[1]*2*datW] = '.'
	#print(fromPos,":",toPos)
	maze[toPos[0]+fromPos[0]+(toPos[1]+fromPos[1])*datW] = '.'

func aroundIndex(x,y):
	var lst = []
	lst.append(pos2Index(x,y-1))
	if x>0:
		lst.append(pos2Index(x-1,y))
	if x<(width-1):
		lst.append(pos2Index(x+1,y))
	lst.append(pos2Index(x,y+1))
	var tmp = []
	for l in lst:
		if l>=0 && l<width*height && !visited.has(l):
			tmp.append(l)
	return tmp

func pos2Index(x,y):
	return x + y * width

func index2Pos(index):
	return [int(index%width),int(index/width)]
