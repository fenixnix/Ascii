extends Grid

class_name Maze3D

func _init(size).(size):
	var tmp = ._init(size)
	Fill(['#','#','#'])
	return tmp

func SetWall(x,y,z,dir,val):
	match dir:
		0:grids[GetIndex([x,y,z])][0] = val
		1:grids[GetIndex([x-1,y,z])][0] = val
		2:grids[GetIndex([x,y,z])][1] = val
		3:grids[GetIndex([x,y-1,z])][1] = val
		4:grids[GetIndex([x,y,z])][2] = val
		5:grids[GetIndex([x,y,z-1])][2] = val

func GetWall(x,y,z,dir):
	match dir:
		0:return grids[GetIndex([x,y,z])][0]
		1:return grids[GetIndex([x-1,y,z])][0]
		2:return grids[GetIndex([x,y,z])][1]
		3:return grids[GetIndex([x,y-1,z])][1]
		4:return grids[GetIndex([x,y,z])][2]
		5:return grids[GetIndex([x,y,z-1])][2]

func CountWall(loc):
	var cnt = 0
	for d in 6:
		if GetWall(loc[0],loc[1],loc[2],d) == '#':
			cnt+=1
	return cnt

func IsDeadEnd(loc):
	return CountWall(loc)>=5

func GetAllDeadEnds():
	var tmp = []
	for i in DataSize():
		if IsDeadEnd(GetLoc(i)):
			tmp.append(i)
	return tmp

func GetAllCrossPoints():
	var tmp = []
	for i in DataSize():
		if CountWall(GetLoc(i))<=3:
			tmp.append(i)
	return tmp

func breakWall(from, to):
	var fromPos = GetLoc(from)
	var toPos = GetLoc(to)
	var dir
	if toPos[0] - fromPos[0] == -1:
		dir = 0
	if toPos[0] - fromPos[0] == 1:
		dir = 1
	if toPos[1] - fromPos[1] == -1:
		dir = 2
	if toPos[1] - fromPos[1] == 1:
		dir = 3
	if toPos[2] - fromPos[2] == -1:
		dir = 4
	if toPos[2] - fromPos[2] == 1:
		dir = 5
	SetWall(toPos[0],toPos[1],toPos[2],dir,'.')

func aroundIndex(xyz):
	var lst = []
	if xyz[0]>0:
		lst.append(GetIndex([xyz[0]-1,xyz[1],xyz[2]]))
	if xyz[0]<size[0]-1:
		lst.append(GetIndex([xyz[0]+1,xyz[1],xyz[2]]))
	if xyz[1]>0:
		lst.append(GetIndex([xyz[0],xyz[1]-1,xyz[2]]))
	if xyz[1]<size[1]-1:
		lst.append(GetIndex([xyz[0],xyz[1]+1,xyz[2]]))
	if xyz[2]>0:
		lst.append(GetIndex([xyz[0],xyz[1],xyz[2]-1]))
	if xyz[2]<size[2]-1:
		lst.append(GetIndex([xyz[0],xyz[1],xyz[2]+1]))
	return lst

func Print():
	for z in size[2]:
		for y in size[1]:
			var line1 = ""
			var line2 = ""
			for x in size[0]:
				var index = GetIndex([x,y,z])
				#if grids[index][3] == '#':
				line1 += '.'
				#else:
				#	line1 += ' '
				line1 += grids[index][0]
				line2 += grids[index][1]
				#line2 += '#'
				if grids[index][2] == '.':
					line2+='*'
				else:
					line2+='#'
				#line2 += grids[index][3]
			print(line1)
			print(line2)
		print('-'.repeat(size[0]*2))
