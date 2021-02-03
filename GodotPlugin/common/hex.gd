class_name HexGrid

static func Pos2Cube(pos:Vector2):
	var x = pos.x - floor(pos.y/2)
	var y = pos.y
	return Vector3(
		x,
		y,
		-x-y
	)

static func Cube2Pos(cube:Vector3):
	return Vector2(cube.x + int(cube.y/2),cube.y)

static func CubeDistance(A,B):
	var d = A-B
	return (abs(d.x)+abs(d.y)+abs(d.z))/2

static func Distance(A,B):
	return CubeDistance(Pos2Cube(A),Pos2Cube(B))

static func HexgonLines(size):
	var tmp = Hexgon(size)
	tmp.append(Vector2(0,-size))
	return tmp

static func Hexgon(size):
	var tmp = []
	var sizeB = size/2
	var sizeC = sizeB*sqrt(3)
	tmp.append(Vector2(sizeC,-sizeB))
	tmp.append(Vector2(sizeC,sizeB))
	tmp.append(Vector2(0,size))
	tmp.append(Vector2(-sizeC,sizeB))
	tmp.append(Vector2(-sizeC,-sizeB))
	tmp.append(Vector2(0,-size))
	return tmp

static func HexArea(center,radius = 1):
	return HexRingRange(center,0,radius)

static func HexRingRange(center,radius_start,width = 1):
	var tmp = []
	for i in range(radius_start,radius_start + width):
		for p in HexRing(center,i):
			tmp.append(p)
	return tmp

static func HexRing(center,dis = 1):
	var tmp = []
	if dis == 0:
		tmp.append(center)
	#->right
	var tmpPos = Vector2(dis,0)+center
	var x_offset = 0
	
	#->bottom right
	if int(tmpPos.y)%2 == 0:
		x_offset = 1
	else:
		x_offset = 0
	for i in dis:
		tmp.append(tmpPos)
		tmpPos += Vector2(-((i+x_offset)%2),1)

	#->top left
	for i in dis:
		tmp.append(tmpPos)
		tmpPos += Vector2(-1,0)
		
	#->left
	if int(tmpPos.y)%2 == 0:
		x_offset = 1
	else:
		x_offset = 0
	for i in dis:
		tmp.append(tmpPos)
		tmpPos += Vector2(-((i+x_offset)%2),-1)

	#->bottom left
	if int(tmpPos.y)%2 == 0:
		x_offset = 0
	else:
		x_offset = 1
	for i in dis:
		tmp.append(tmpPos)
		tmpPos += Vector2((i+x_offset)%2,-1)

	#->bottom right
	for i in dis:
		tmp.append(tmpPos)
		tmpPos += Vector2(1,0)
		
	#->right
	if int(tmpPos.y)%2 == 0:
		x_offset = 0
	else:
		x_offset = 1
	for i in dis:
		tmp.append(tmpPos)
		tmpPos += Vector2((i+x_offset)%2,1)
	return tmp
