class_name Grid2D

var grids = []
var width:int = 1
var height:int = 1

func _init(w:int,h:int):
	width = w
	height = h
	grids.resize(width*height)

func Fill(val):
	for i in width*height:
		grids[i] = val

func Clear():
	Fill(null)

func Count(val):
	var tmp = 0;
	for y in height:
		for x in width:
			match Get(x,y):
				val:tmp+=1
	return tmp

func FillSubRect(val,rect:Rect2):
	for y in range(rect.position.y,rect.end.y):
		for x in range(rect.position.x,rect.end.x):
			Set(x,y,val)

func FillMask(val,mask:Grid2D):
	for y in height:
		for x in width:
			if mask.Get(x,y):
				Set(x,y,val)

func FillFlow(x,y,val):
	var seedVal = Get(x,y)
	var stack = []
	stack.append(Vector2(x,y))
	while len(stack)>0:
		var tail = stack.pop_back()
		var left = 0
		var right = width
		for x in range(tail.x,0,-1):
			match GetVal(x,tail.y):
				seedVal,val:
					SetVal(x,tail.y,val)
					left = x
				_:break

		for x in range(tail.x,width):
			match GetVal(x,tail.y):
				seedVal,val:
					SetVal(x,tail.y,val)
					right = x
				_:break
		fill_scan_y(left,right,tail.y-1,seedVal,stack)
		fill_scan_y(left,right,tail.y+1,seedVal,stack)

func FillRegion(region,index,val):
	for y in height:
		for x in width:
			if region.Get(x,y) == index:
				Set(x,y,val)

func FindCenter(mark):
	var min_x = width
	var max_x = 0
	var min_y = height
	var max_y = 0
	for y in height:
		for x in width:
			if Get(x,y) == mark:
				min_x = min(x,min_x)
				max_x = max(x,max_x)
				min_y = min(y,min_y)
				max_y = max(y,max_y)
	return Vector2((min_x+max_x)/2,(min_y+max_y)/2).floor()

func FindGCenter(mark):
	var sum_x = 0
	var sum_y = 0
	var area = 0
	for y in height:
		for x in width:
			if Get(x,y) == mark:
				sum_x += x
				sum_y += y
				area += 1
	return Vector2(sum_x/area,sum_y/area).floor()

func RemoveBorderRegion():
	for y in height:
		for x in width:
			if x == 0||y==0||x == width-1||y==height-1:
				if Get(x,y)!=-1:
					FillFlow(x,y,-1)

func GetAllPoints(val):
	var all_points = []
	for y in height:
		for x in width:
			if Get(x,y) == val:
				all_points.push_back([x,y])
	return all_points

func GetCells(mark):
	var tmp = []
	for y in height:
		for x in width:
			match Get(x,y):
				mark:
					tmp.append(PG_Def.PosToIndex(x,y))
	return tmp

func Segmentation(mark):
	var index = 0
	for y in height:
		for x in width:
			match GetVal(x,y):
				mark:
					FillFlow(x,y,index)
					index+=1
	return index

func fill_scan_y(left,right,y,seedVal,stack):
	var find = false
	var lastX = left
	for x in range(left,right):
		var v = GetVal(x,y)
		if typeof(v) == typeof(seedVal) && v == seedVal:
			find = true
			lastX = x
		else:
			if find:
				stack.append(Vector2(lastX,y))
				find = false
	if find:
		stack.append(Vector2(lastX,y))

func FindAdjoins(mark):
	var tmp = []
	for y in height:
		for x in width:
			if Get(x,y) == mark:
				for j in adjoins(x,y):
					if typeof(j) == 2:
						if !tmp.has(j)&&j!=-1:
							tmp.append(j)
	return tmp

func adjoins(x,y):
	var tmp = []
	var val = Get(x,y)
	var up = GetVal(x,y-1)
	var left = GetVal(x-1,y)
	var right = GetVal(x+1,y)
	var down = GetVal(x,y+1)
	if up!=val:
		tmp.append(up)
	if left!=val:
		tmp.append(left)
	if right!=val:
		tmp.append(right)
	if down!=val:
		tmp.append(down)
	return tmp

func Noise(val,rate=50):
	for y in height:
		for x in width:
			if randi()%100<rate:
				Set(x,y,val)

func Voronoi(points):
	for y in height:
		for x in width:
			var p = Vector2(x,y)
			var minVal = 999999999
			var minIndex = 0
			for i in points.size():
				var disSqr = points[i].distance_squared_to(p)
				if disSqr<=minVal:
					minVal = disSqr
					minIndex = i
			Set(x,y,minIndex)

func SetVal(x,y,new_val):
	if x<0||x>=width||y<0||y>=height:
		return
	grids[x+y*width] = new_val

func Set(x,y,new_val):
	grids[x+y*width] = new_val

func SetIndex(index,val):
	SetVal(index%PG_Def.MAX_W,index/PG_Def.MAX_W,val)

func Get(x,y):
	return grids[x+y*width]

func GetVal(x,y):
	if x<0||x>=width||y<0||y>=height:
		return null
	return grids[x+y*width]

func GetNum(x,y):
	var res = GetVal(x,y)
	if res == null:
		return 0
	return res

func IsEdge(x,y,src,side):
	if GetVal(x,y) == src:
		if GetVal(x,y-1) == side:
			return true
		if GetVal(x-1,y) == side:
			return true
		if GetVal(x+1,y) == side:
			return true
		if GetVal(x,y+1) == side:
			return true
	return false

func GetEdges(A,B):
	var tmp = []
	for y in height:
		for x in width:
			if IsEdge(x,y,A,B):
				tmp.append([x,y])
	return tmp

func GetRndEdge(A,B):
	var points = GetEdges(A,B)
	return points[randi()%len(points)]

func IsBorder(x,y,mark):
	if Get(x,y) == mark:
		if GetVal(x+1,y) != mark:
			return true
		if GetVal(x-1,y) != mark:
			return true
		if GetVal(x,y+1) != mark:
			return true
		if GetVal(x,y-1) != mark:
			return true
	return false

func DrawHoriLine(x1,x2,y,val):
	for x in range(x1,x2):
		SetVal(x,y,val)
		
func DrawVertLine(y1,y2,x,val):
	for y in range(y1,y2):
		SetVal(x,y,val)
		
func DrawLine(x1,y1,x2,y2,val):
	if y1 != y2:
		for y in range(y1,y2+1):
			var x = (y-y1)*(x2-x1)/(y2-y1) + x1
			SetVal(x,y,val)
	if x1 != x2:
		for x in range(x1,x2+1):
			var y = (x-x1)*(y2-y1)/(x2-x1) + y1
			SetVal(x,y,val)

func MakeBorder(val = '#'):
	DrawHoriLine(0,width,0,val)
	DrawVertLine(0,height,0,val)
	DrawVertLine(0,height,width-1,val)
	DrawHoriLine(0,width,height-1,val)

func Cover(x,y,src:Grid2D):
	for sy in src.height:
		for sx in src.width:
			SetVal(x+sx,y+sy,src.GetVal(sx,sy))

func CoverWithMask(src:Grid2D,mask:Grid2D):
	for y in src.height:
		for x in src.width:
			if mask.Get(x,y): 
				Set(x,y,src.Get(x,y))

func Replace(src,dst):
	for y in height:
		for x in width:
			if GetVal(x,y) == src:
				SetVal(x,y,dst)

func RandReplace(src,dst,rate = 100):
	for y in height:
		for x in width:
			if GetVal(x,y) == src:
				if randi()%100<rate:
					SetVal(x,y,dst)

func Score(src,score):
	for y in height:
		for x in width:
			if Get(x,y) == src:
				Set(x,y,score)
			else:
				Set(x,y,0)
	return self

func SumAround(x,y,rng):
	var sum = 0
	for oy in range(y-rng,y+rng):
		for ox in range(x-rng,x+rng):
			if rng>=abs(ox-x)+abs(oy-y):
				sum += GetNum(ox,oy)
	return sum

func MaxPoint():
	var maxVal = 0
	var maxPos = Vector2(0,0)
	for y in height:
		for x in width:
			var val = GetNum(x,y)
			if val>maxVal:
				maxVal = val
				maxPos = Vector2(x,y)
	return [maxPos,maxVal]

func MaxPoints():
	var maxP = MaxPoint()
	var tmp = []
	for y in height:
		for x in width:
			var val = GetNum(x,y)
			if val == maxP[1]:
				tmp.append(Vector2(x,y))
	return tmp

func FillDiamond(center,rng = 9,val = 0):
	for oy in range(center.y-rng,center.y+rng):
		for ox in range(center.x-rng,center.x+rng):
			if rng>=abs(ox-center.x)+abs(oy-center.y):
				SetVal(ox,oy,val)

func Normalize():
	var maxVal = 0
	var minVal = 999999
	for y in height:
		for x in width:
			var val = GetNum(x,y)
			maxVal = max(val,maxVal)
			minVal = min(val,minVal)
	var dif = maxVal - minVal
	if dif == 0:
		return
	for y in height:
		for x in width:
			var val = GetNum(x,y)
			SetVal(x,y,(val-minVal)/float(dif))

func Add(g):
	for y in height:
		for x in width:
			SetVal(x,y,GetNum(x,y)+g.GetNum(x,y))
	return self

func Thresh(thresh):
	for y in height:
		for x in width:
			SetVal(x,y,GetVal(x,y)>=thresh)
	return self

func Index(x,y):
	return PG_Def.Vec2Index(Vector2(x,y))

func CountAround(x,y,val = '#'):
	var cnt = 0
	for r in range(y-1,y+2):
		for c in range(x-1,x+2):
			if x == c && y == r:
				continue
			if GetVal(c,r) == val:
				cnt+=1
	return cnt

#func RotCW():
#	var tmpGrid = Grid2D.new(width,height)
#	for y in height:
#		for x in width:
#			tmpGrid.SetVal(x,y,GetVal(height-1-y,x))
#	return tmpGrid
#
#func RotCCW():
#	var tmpGrid = Grid2D.new(width,height)
#	for y in height:
#		for x in width:
#			tmpGrid.SetVal(x,y,GetVal(y,width-1-x))
#	return tmpGrid
#

#func Repeat(w:int = 0, h:int = 0):
#	var tmpGrid = Grid2D.new(width*(1+w),height*(1+h))
#	for y in range(h):
#		for x in range(w):
#			tmpGrid.Cover(width*x,height*y,self)
#	return tmpGrid
#
#func Expend(x:int = 0, y:int = 0):
#	var tmpGrid = Grid2D.new(width+x,height+y)
#	tmpGrid.Cover(0,0,self)
#	var subRight = Sub(Rect2(width-1,0,1,height))
#	tmpGrid.Cover(width,0,subRight.Repeat(x,0))
#	var subBottom = Sub(Rect2(0,height-1,width,1))
#	tmpGrid.Cover(0,height,subBottom.Repeat(0,y))
#	tmpGrid.FillSubRect(GetVal(width-1,height-1),Rect2(width,height,x,y))
#	return tmpGrid

#func Mirror(hori:bool,vert:bool):
#	var tmp = Clone()
#	if hori:
#		tmp = tmp.MirrorHori()
#	if vert:
#		tmp = tmp.MirrorVert()
#	return tmp
#
#func MirrorHori():
#	var tmpGrid = Grid2D.new(width*2,height)
#	tmpGrid.Cover(Vector2.ZERO,self)
#	tmpGrid.Cover(Vector2(width,0),FlipHori())
#	return tmpGrid
#
#func MirrorVert():
#	var tmpGrid = Grid2D.new(width,height*2)
#	tmpGrid.Cover(Vector2.ZERO,self)
#	tmpGrid.Cover(Vector2(0,height),FlipVert())
#	return tmpGrid
