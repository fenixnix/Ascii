class_name GenDungeon

#生成迷宫
#生成房间
#连接房间
#根据房间计算迷宫深度
#挑选最深的深度，随机两端作为起点和终点
#根据起点根据路程进行房间等级分布

static func Gen(size,cell_size = Vector2(7,7),rate = 70,type = null):
	var mazeDat = GenMaze(size,rate)
	var maze:Grid2DMaze = mazeDat[0]
	var layer = mazeDat[1]
	print("Start:%d,End:%d"%[layer.StartID(),layer.EndID()])
	var map = LayerToMap(layer,cell_size)
	GridProc.Print(map)
	return {"layer":layer,"map":map}

static func LayerToMap(layer,cell_size):
	var areas = layer.areas
	var map = Grid2D.new(layer.w*cell_size.x,layer.h*cell_size.y)
	map.Fill(' ')
#	var offset = (cell_size/2).floor()
	#fill room
	for r in areas.values():
		if r.IsRoom:
			map.FillSubRect('.',Rect2(r.x*cell_size.x,r.y*cell_size.y,cell_size.x,cell_size.y))
			if layer.UpWall(r.id):
				map.DrawLine(r.x*cell_size.x,r.y*cell_size.y,(r.x+1)*cell_size.x-1,(r.y)*cell_size.y,'#')
			if layer.DownWall(r.id):
				map.DrawLine(r.x*cell_size.x,(r.y+1)*cell_size.y-1,(r.x+1)*cell_size.x-1,(r.y+1)*cell_size.y-1,'#')
			if layer.LeftWall(r.id):
				map.DrawLine(r.x*cell_size.x,r.y*cell_size.y,r.x*cell_size.x,(r.y+1)*cell_size.y-1,'#')
			if layer.RightWall(r.id):
				map.DrawLine((r.x+1)*cell_size.x-1,r.y*cell_size.y,(r.x+1)*cell_size.x-1,(r.y+1)*cell_size.y-1,'#')

	#add corrider
	var x_off = floor(cell_size.x/2);
	var y_off = floor(cell_size.y/2);
	for r in areas.values():
		for l in r.links:
			if areas.keys().has(int(l)):
				if areas.has(int(l)):
					var d = areas[int(l)]
					map.DrawLine(
						r.x*cell_size.x + x_off,
						r.y*cell_size.y + y_off,
						d.x*cell_size.x + x_off,
						d.y*cell_size.y + y_off,
						'.'
						)
	#add door
	for r in areas.values():
		if r.IsRoom:
			if layer.UpDoor(r.id):
				map.Set(r.x*cell_size.x+x_off,r.y*cell_size.y,'+')
			if layer.LeftDoor(r.id):
				map.Set(r.x*cell_size.x,r.y*cell_size.y+y_off,'+')
			if layer.RightDoor(r.id):
				map.Set((r.x+1)*cell_size.x-1,r.y*cell_size.y+y_off,'+')
			if layer.DownDoor(r.id):
				map.Set(r.x*cell_size.x+x_off,(r.y+1)*cell_size.y-1,'+')
	
	#add center
	for r in areas.values():
		if r.IsRoom:
			map.Set(r.x*cell_size.x+x_off,r.y*cell_size.y+y_off,'*')
		
	return map

	
static func GenMaze(size,rate):
	var mazeGen = Prim.new()
	var maze:Grid2DMaze = mazeGen.Gen(size.x,size.y)
	var validRooms = SelVldRooms(size.x*size.y,rate)
	
	var layer = DungeonLayer.new(size.x,size.y)
	
	for r in size.x*size.y:
		layer.AddArea(r,r%int(size.x),r/int(size.y))
		
	#choice room
	for v in validRooms:
		layer.areas[v].IsRoom = true
	
	#Find links
	for r in size.x*size.y:
		var x = r%int(size.x)
		var y = r/int(size.y)
		if maze.UpWall(x,y) == '.':
			layer.areas[int(r)].links.append(int(r-size.x))
		if maze.LeftWall(x,y) == '.':
			layer.areas[int(r)].links.append(int(r-1))
		if maze.RightWall(x,y) == '.':
			layer.areas[int(r)].links.append(int(r+1))
		if maze.DownWall(x,y) == '.':
			layer.areas[int(r)].links.append(int(r+size.x))
	
	#Gen Cell Levels
	var lvs = maze.GenRoomLevel()
	for r in size.x*size.y:
		layer.areas[r].lv= lvs[r]
	
	#Erase DeadEnd
	layer.EraseAllDeadEnd()
	
	GridProc.Print(maze)
	return [maze,layer];

static func SelVldRooms(cnt,rate):
	var tmp = []
	for i in cnt:
		tmp.append(i)
	tmp.shuffle()
	return tmp.slice(0,cnt*rate/100)

class DungeonLayer:
	var DefaultArea = DungeonArea.new(-1,0,0)
	var w:int = 1;
	var h:int = 1;
	var areas = {}
	
	func _init(w,h):
		self.w = w
		self.h = h
	
	func ToJson():
		var tArr = []
		for a in areas:
			tArr.append(areas[a].ToJson())
		var dat = {"w":w,"h":h,"areas":tArr}
		return dat
	
	func AddArea(id, x, y):
		areas[id] = DungeonArea.new(id,x,y)
		
	func EndID():
		var maxID = 0
		var maxVal = 0
		for a in areas.values():
			if a.lv>maxVal:
				maxVal = a.lv
				maxID = a.id
		return maxID
	
	func StartID():
		var minID = 0
		var minVal = 9999;
		for a in areas.values():
			if a.lv<minVal:
				minVal = a.lv
				minID = a.id
		return minID
	
	func EraseAllDeadEnd():
		while CountDeadEnd()>0:
			EraseDeadEnd()

	func EraseDeadEnd():
		for a in areas.keys():
			if areas[a].IsDeadEnd():
				areas.erase(a)
				for av in areas.values():
					av.Disconnect(a)
	
	func CountDeadEnd():
		var cnt = 0;
		for a in areas.values():
			if a.IsDeadEnd():
				cnt+=1;
		return cnt;
		
	func Get(id):
		return areas[id]

	func UpOpen(id):
		return areas[id].links.has(int(id-w))
		
	func LeftOpen(id):
		if id%w<=0:
			return false
		return areas[id].links.has(int(id-1))
		
	func RightOpen(id):
		if id%w>=w-1:
			return false
		return areas[id].links.has(int(id+1))
		
	func DownOpen(id):
		return areas[id].links.has(int(id+w))
		
	func UpWall(id):
		return !(UpOpen(id)&&Up(id).IsRoom)

	func LeftWall(id):
		return !(LeftOpen(id)&&Left(id).IsRoom)
	
	func RightWall(id):
		return !(RightOpen(id)&&Right(id).IsRoom)
	
	func DownWall(id):
		return !(DownOpen(id)&&Down(id).IsRoom)
		
	func UpDoor(id):
		return UpOpen(id)&&!Up(id).IsRoom
	func LeftDoor(id):
		return LeftOpen(id)&&!Left(id).IsRoom
	func RightDoor(id):
		return RightOpen(id)&&!Right(id).IsRoom
	func DownDoor(id):
		return DownOpen(id)&&!Down(id).IsRoom

	func Up(id):
		var upID = id-w;
		if upID<0:
			return DefaultArea
		return areas.get(int(upID),DefaultArea)
	
	func Left(id):
		if id%w<=0:
			return DefaultArea
		return areas.get(int(id-1),DefaultArea)
		
	func Right(id):
		if id%w>=w-1:
			return DefaultArea
		return areas.get(int(id+1),DefaultArea)
		
	func Down(id):
		var downID = id+w;
		if downID/w>=h:
			return DefaultArea
		return areas.get(int(downID),DefaultArea)


class DungeonArea:
	var id = 0
	var lv = 0
	var x = 0
	var y = 0
	var IsRoom = false
	var links = []
	
	func _init(id,x,y):
		self.id = id
		self.x = x
		self.y = y
		
	func IsDeadEnd():
		if IsRoom:
			return false
		return len(links)<=1
	
	func Disconnect(id:int):
		links.erase(id)
	
	func ToJson():
		var tmp = {"id":id,"lv":lv,"x":x,"y":y,"IsRoom":IsRoom,"links":links}
		return tmp
