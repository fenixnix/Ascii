class_name AStarGrid3D

var astar:AStar
var maze:Maze3D

func _init(_maze):
	astar = AStar.new()
	SetMaze(_maze)

func SetMaze(maze):
	self.maze = maze
	astar.clear()
	for z in maze.size[2]:
		for y in maze.size[1]:
			for x in maze.size[0]:
				var index = maze.GetIndex([x,y,z])
				astar.add_point(index, Vector3(x,y,z))
	
	for z in maze.size[2]:
		for y in maze.size[1]:
			for x in maze.size[0]:
				var index = maze.GetIndex([x,y,z])
				if(maze.GetWall(x,y,z,0)=='.'):
					astar.connect_points(index,maze.GetIndex([x+1,y,z]))
				if(maze.GetWall(x,y,z,2)=='.'):
					astar.connect_points(index,maze.GetIndex([x,y+1,z]))
				if(maze.GetWall(x,y,z,4)=='.'):
					astar.connect_points(index,maze.GetIndex([x,y,z+1]))

func CalcID(start,goal):
	return astar.get_point_path(start,goal)

func CalcPoint(start:Vector3,goal:Vector3):
	return astar.get_point_path(maze.GetIndex([start.x,start.y,start.z]),maze.GetIndex([goal.x,goal.y,goal.z]))

func CalcDepthestPath():
	var size = len(astar.get_points())
	var start
	var end
	var maxDepth = 0
	for i in size:
		for j in size-i:
			var depth = len(CalcID(i,j))
			if depth>maxDepth:
				maxDepth = depth
				start = i
				end = j
	return [start,end]

func CalcDepthestPathFromStart(start,ends):
	var size = len(astar.get_points())
	var end
	var maxDepth = 0
	for e in ends:
		var depth = len(CalcID(start,e))
		if depth>maxDepth:
			maxDepth = depth
			end = e
	return end
