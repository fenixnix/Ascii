extends Node

func MarkMazeEndPoints(maze):
	var size = maze.MazeSize()
	var tmpDat = []
	var points = []
	for y in size.y:
		for x in size.x:
			if maze.IsDeadEnd(x,y):
				tmpDat.append(true)
				points.append(x+y*size.x)
			else:
				tmpDat.append(false)
	#Print
#	for y in maze.height:
#		var line = ""
#		for x in maze.width:
#			if tmpDat[x+y*maze.width]:
#				line += "*"
#			else:
#				line += "."
#		print(line)
	return {"grid":tmpDat,"points":points}

func MarkMazeCrossPoints(maze):
	var size = maze.MazeSize()
	var tmpDat = []
	var points = []
	for y in size.y:
		for x in size.x:
			if maze.CountWallAroundNot(x,y)<=1:
				tmpDat.append(true)
				points.append(x+y*size.x)
			else:
				tmpDat.append(false)
	# for y in maze.height:
	# 	var line = ""
	# 	for x in maze.width:
	# 		if tmpDat[x+y*maze.width]:
	# 			line += "*"
	# 		else:
	# 			line += "."
	# 	print(line)
	return {"grid":tmpDat,"points":points}
