class_name Grid2D_AStar

var astar:AStar2D
var maze

func _init():
	astar = AStar2D.new()

func SetMaze(maze):
	self.maze = maze
	astar.clear()
	for y in maze.MazeSize().y:
		for x in maze.MazeSize().x:
			var index = maze.MazeIndex(x,y)
			astar.add_point(index, Vector2(x,y))
	for y in maze.MazeSize().y:
		for x in maze.MazeSize().x:
			var index = maze.MazeIndex(x,y)
			if(maze.RightWall(x,y) == "."):
				astar.connect_points(index,maze.MazeIndex(x+1,y))
			if(maze.DownWall(x,y) == "."):
				astar.connect_points(index,maze.MazeIndex(x,y+1))

func CalcID(start,goal):
	return astar.get_point_path(start,goal)

func CalcPoint(start:Vector2,goal:Vector2):
	return astar.get_point_path(maze.MazeIndex(start.x,start.y),maze.MazeIndex(goal.x,goal.y))

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
