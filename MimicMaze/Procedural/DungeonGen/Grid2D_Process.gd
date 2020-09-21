extends Node

class_name GridProc

const MAX_W = 4096

static func Print(grid):
	print("*** W:%3d * H:%3d ***"%[grid.width,grid.height])
	var tmp = Scale(grid,Vector2(1,1))
	for y in tmp.height:
		var line = ""
		for x in tmp.width:
			match tmp.GetVal(x,y):
				true:line+="#"
				false:line+="."
				_:line+=str(tmp.GetVal(x,y))
		print(line)

static func Sub(grid,rect:Rect2):
	var tmpGrid = Grid2D.new(rect.size.x,rect.size.y)
	for y in range(rect.position.y,rect.end.y):
		for x in range(rect.position.x,rect.end.x):
			tmpGrid.SetVal(x-rect.position.x,y-rect.position.y,grid.GetVal(x,y))
	return tmpGrid

static func CloneMask(grid,mask,fillEmpty = " "):
	var tmp = Grid2D.new(grid.width,grid.height)
	for y in grid.height:
		for x in grid.width:
			if mask.Get(x,y):
				tmp.SetVal(x,y,grid.Get(x,y))
			else:
				tmp.SetVal(x,y,fillEmpty)
	return tmp

static func MakeRegionBorder(src,region_mark,borderMark)->Grid2D:
	var tmp = Clone(src)
	for y in src.height:
		for x in src.width:
			if src.IsBorder(x,y,region_mark):
				tmp.Set(x,y,borderMark)
	return tmp

static func MakeSplitLine(src:Grid2D,A,B,splitMark)->Grid2D:
	var tmp = Clone(src)
	for y in src.height:
		for x in src.width:
			if src.IsEdge(x,y,A,B):
				tmp.Set(x,y,splitMark)
	return tmp

static func MakeMaskBorder(src:Grid2D,mask:Grid2D,mark)->Grid2D:
	var tmp = Clone(src)
	for y in src.height:
		for x in src.width:
			if mask.IsEdge(x,y,true,false):
				tmp.Set(x,y,mark)
	return tmp

static func GetSubRegion(map,mark):#return mask,roi,area
	var up = 2048
	var left = 2048
	var right = 0
	var bottom = 0
	var area = 0
	var tmp = Grid2D.new(map.width,map.height)
	tmp.Fill(false)
	for y in map.height:
		for x in map.width:
			if typeof(map.GetVal(x,y)) == typeof(mark):
				if map.GetVal(x,y) == mark:
					if y<up:
						up = y
					if y>bottom:
						bottom = y
					if x<left:
						left = x
					if x>right:
						right = x
					tmp.Set(x,y,true)
					area+=1
	var roi = Rect2(left,up,right-left,bottom-up)
	print("land: roi:%s,area:%d"%[str(roi),area])
	return [tmp,roi,area]

static func GetCellsWithMask(mask):
	var tmp = []
	for y in mask.height:
		for x in mask.width:
			if mask.Get(x,y):
				tmp.append(PosToIndex(x,y))
	return tmp

static func PosToIndex(x,y):
	return x+y*MAX_W

static func Clone(grid)->Grid2D:
	return Sub(grid,Rect2(0,0,grid.width,grid.height))

static func GetMask(map,key):
	var tmp = Grid2D.new(map.width,map.height)
	for y in map.height:
		for x in map.width:
			tmp.Set(x,y,map.Get(x,y) == key)
	return tmp

static func GetEdgeMask(map,src,side):
	var tmp = Grid2D.new(map.width,map.height)
	for y in map.height:
		for x in map.width:
			if map.IsEdge(x,y,src,side):
				tmp.Set(x,y,true)
			else:
				tmp.Set(x,y,false)
	return tmp

static func RandErode(grid,src = '#',dst = '.',rate = 100):
	var tmp = Clone(grid)
	for y in tmp.height:
		for x in tmp.width:
			var val = grid.Get(x,y)
			if val == src:
				if randi()%8+1>grid.CountAround(x,y,val):
					tmp.Set(x,y,dst)
	return tmp

static func VoronoiWithMask(points,mask):
	var tmp = Grid2D.new(mask.width,mask.height)
	for y in mask.height:
		for x in mask.width:
			if mask.Get(x,y) == true:
				var p = Vector2(x,y)
				var minVal = 99999999
				var minIndex = 0
				for i in points.size():
					var disSqr = points[i].distance_squared_to(p)
					if disSqr<=minVal:
						minVal = disSqr
						minIndex = i
				tmp.Set(x,y,minIndex)
			else:
				tmp.Set(x,y,-1)
	return tmp

static func Voronoi(points,width,height)->Grid2D:
	var tmp = Grid2D.new(width,height)
	for y in height:
		for x in width:
			var p = Vector2(x,y)
			var minVal = width*height
			var minIndex = 0
			for i in points.size():
				var disSqr = points[i].distance_squared_to(p)
				if disSqr<=minVal:
					minVal = disSqr
					minIndex = i
			tmp.Set(x,y,minIndex)
	return tmp

static func GenRndPointsInMask(cnt,mask:Grid2D,val = true):
	var all_points = mask.GetAllPoints(val)
	all_points.shuffle()
	var tmpPoints = []
	for i in cnt:
		tmpPoints.append(Vector2(all_points[i][0],all_points[i][1]))
	return tmpPoints

static func ImprovePoints(width,height,points):
	var tmp = []
	var mask = Grid2D.new(width,height)
	mask.Fill(true)
	var voronoi = Voronoi(points,width,height)
	for i in len(points):
		var new_point = voronoi.FindCenter(i)
		#print(new_point)
		tmp.append(new_point)
	return tmp

static func ImprovePointsInMask(points,mask):
	var tmp = []
	var voronoi = VoronoiWithMask(points,mask)
	for i in len(points):
		var new_point = voronoi.FindCenter(i)
		#print(new_point)
		tmp.append(new_point)
	return tmp

static func CalcSiteScore(src,mask = null):
	var sea = Clone(src).Score('~',2)
	var land = Clone(src).Score('.',3)
	var mountain = Clone(src).Score('^',-1)
	var score = Add(sea,land)
	score.Add(mountain)
	return SumAroundMap(score,8,mask)

static func CalcCaveScore(src,mask = null):
	var land = Clone(src).Score(".",1)
	var mountain = Clone(src).Score('^',2)
	var score = Add(land,mountain)
	return SumAroundMap(score,8,mask)

static func CalcPortScore(src,mask = null):
	var land = Clone(src).Score(".",1)
	var sea = Clone(src).Score('~',2)
	var score = Add(land,sea)
	return SumAroundMap(score,8,mask)

static func SumAroundMap(src,rng = 4,mask = null):
	var tmp = Clone(src)
	if mask == null:
		for y in tmp.height:
			for x in tmp.width:
				tmp.Set(x,y,src.SumAround(x,y,rng))
	else:
		for y in tmp.height:
			for x in tmp.width:
				if mask.Get(x,y):
					tmp.Set(x,y,src.SumAround(x,y,rng))
	return tmp

static func Add(a,b):
	if a.width != b.width || a.height != b.height:
		return
	var tmp = Clone(a)
	for y in tmp.height:
		for x in tmp.width:
			tmp.Set(x,y,a.GetNum(x,y)+b.GetNum(x,y))
	return tmp

static func Flip(grid,hori:bool,vert:bool):
	var tmp = Clone(grid)
	if hori:
		tmp = tmp.FlipHori(grid)
	if vert:
		tmp = tmp.FlipVert(grid)
	return tmp

static func FlipHori(grid):
	var tmpGrid = Grid2D.new(grid.width,grid.height)
	for y in grid.height:
		for x in grid.width:
			tmpGrid.SetVal(x,y,grid.GetVal(grid.width-1-x,y))
	return tmpGrid

static func FlipVert(grid):
	var tmpGrid = Grid2D.new(grid.width,grid.height)
	for y in grid.height:
		for x in grid.width:
			tmpGrid.SetVal(x,y,grid.GetVal(x,grid.height-1-y))
	return tmpGrid
	
static func Scale(grid:Grid2D,size:Vector2 = Vector2.ONE):
	var tmpGrid = Grid2D.new(grid.width*size.x,grid.height*size.y)
	for y in tmpGrid.height:
		for x in tmpGrid.width:
			tmpGrid.SetVal(x,y,grid.GetVal(x/size.x,y/size.y))
	return tmpGrid
