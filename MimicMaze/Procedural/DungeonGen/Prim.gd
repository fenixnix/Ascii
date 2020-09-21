class_name Prim

var grid
var readyWall = []
var readyWallSrc = []
var maze = []
var width = 1
var height = 1

var currentPos = Vector2.ZERO

func Gen(x:int = 0,y:int = 0,w:int = 1,h:int = 1)->Grid2D:
	width = w
	height = h
	grid = Grid2DMaze.new(w,h)
	grid.Fill('#')
	readyWall.clear()
	readyWallSrc.clear()
	maze.clear()
	#currentPos = Vector2(x,y)
	currentPos = Vector2(randi()%w,randi()%h)
	CheckAddNew(currentPos)
	while len(readyWall)>0:
		Run(currentPos)
	return grid
	
func Run(pos):
	maze.append(grid.Index(pos.x,pos.y))
	CheckAddNew(pos)
	if len(readyWall)<=0:
		return
	var selIndex = randi()%len(readyWall)
	var dstIndex = readyWall[selIndex]
	var srcIndex = readyWallSrc[selIndex]
	var src = PG_Def.Index2Vec(srcIndex)
	var dst = PG_Def.Index2Vec(dstIndex)
	grid.SetCell(src.x,src.y,'.')
	grid.SetCell(dst.x,dst.y,'.')
	grid.SetVal(src.x+dst.x,src.y+dst.y,'.')
	readyWall.remove(selIndex)
	readyWallSrc.remove(selIndex)
	currentPos = dst
	
func CheckAddNew(pos):
	var lst = []
	lst.append(pos+Vector2.UP)
	lst.append(pos+Vector2.LEFT)
	lst.append(pos+Vector2.RIGHT)
	lst.append(pos+Vector2.DOWN)
	for p in lst:
		if p.x<0||p.x>=width||p.y<0||p.y>=height:
			continue
		var index:int = PG_Def.Vec2Index(p)
		if readyWall.has(index):
			continue
		if maze.has(index):
			continue
		readyWall.append(index)
		readyWallSrc.append(PG_Def.Vec2Index(pos))
