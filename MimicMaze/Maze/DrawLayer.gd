extends Node2D

var layer = 0
var maze:Maze3D = null
var fog:Grid = null
var bgColor = Color(0,0,0,0.8)
var wallColor = Color(1,0.1,0.5,1)

var tColor = Color(1,1,1,0)

func UpFadeIn():
	tween(tColor,Color.white,0.8,1)

func UpFadeOut():
	tween(Color.white,tColor,1,1.2)

func DownFadeIn():
	tween(tColor,Color.white,1.2,1)

func DownFadeOut():
	tween(Color.white,tColor,1.0,0.8)

func tween(startColor,endColor,startScale,endScale):
	var size = Vector2(maze.size[0],maze.size[1])*MazeDefine.gridSize/2
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self,"modulate",startColor,endColor,.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.interpolate_property(self,"scale",startScale*Vector2.ONE,endScale*Vector2.ONE,.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.interpolate_property(self,"position",(1.0-startScale)*size,(1.0-endScale)*size,.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()
	yield(tween,"tween_all_completed")
	tween.queue_free()

func _draw():
	if maze == null:
		return
	#draw_set_transform(-(Vector2(maze.size[0],maze.size[1])*MazeDefine.gridSize)/2,0,Vector2.ONE)
	draw_rect(Rect2(Vector2.ZERO,Vector2(maze.size[0],maze.size[1])*MazeDefine.gridSize),bgColor)
	draw_line(Vector2.ZERO-Vector2(1.5,0),Vector2(maze.size[0],0)*MazeDefine.gridSize+Vector2(1.5,0),wallColor,3)
	draw_line(Vector2.ZERO-Vector2(0,1.5),Vector2(0,maze.size[1])*MazeDefine.gridSize+Vector2(0,1.5),wallColor,3)
	var z = layer
	for y in maze.size[1]:
		for x in maze.size[0]:
			if maze.GetWall(x,y,z,4) != "#":#floor
				draw_rect(Rect2(Vector2(x,y)*MazeDefine.gridSize+Vector2.ONE*MazeDefine.gridSize*0.25,
				Vector2.ONE*MazeDefine.gridSize*0.5),wallColor,false,3)
			if maze.GetWall(x,y,z,0) == "#":
				draw_line(Vector2(x+1,y)*MazeDefine.gridSize-Vector2(0,1.5),
				Vector2(x+1,y+1)*MazeDefine.gridSize+Vector2(0,1.5),wallColor,3)
			if maze.GetWall(x,y,z,2) == "#":
				draw_line(Vector2(x,y+1)*MazeDefine.gridSize-Vector2(1.5,0),
				Vector2(x+1,y+1)*MazeDefine.gridSize + Vector2(1.5,0),wallColor,3)
			if maze.GetWall(x,y,z,5) != "#":#ceiling
				draw_rect(Rect2(Vector2(x,y)*MazeDefine.gridSize,
				Vector2.ONE*MazeDefine.gridSize),wallColor,true)
	if fog == null:
		return
	var mazeSize = maze.MazeSize()
	for y in mazeSize.y:
		for x in mazeSize.x:
			if fog.Get([x,y,0]):
				draw_rect(Rect2(Vector2(x,y)*MazeDefine.gridSize,
				Vector2.ONE*MazeDefine.gridSize),
				Color.black)
