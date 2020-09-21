extends Node2D

var z = 0
var maze:Maze3D = null
var wallColor = Color.purple

var openFloor = preload("res://Maze/OpenFloor.tres")

var location = Vector3.ZERO
var renderVectorX = Vector3(1,0,0)
var renderVectorY = Vector3(0,1,0)

onready var rot3D:Spatial = get_node("../Draw3D/Center")

func _draw():
	if maze == null:
		return
	var mazeSize = Vector3(maze.size[0],maze.size[1],maze.size[2])
	var w = renderVectorX.dot(mazeSize)
	var h = renderVectorY.dot(mazeSize)

	#draw floor
#	draw_rect(Rect2(Vector2.ZERO,Vector2(w,h)*MazeDefine.gridSize),Color(.2,.2,.2,.5))
#	for y in h:
#		for x in w:
#			if maze.GetWall(x,y,z,4)=='.'||maze.GetWall(x,y,z,5)=='.':
#				draw_style_box(openFloor,Rect2(Vector2(x,y)*MazeDefine.gridSize,Vector2.ONE*MazeDefine.gridSize))

	#draw wall
	draw_line(Vector2.ZERO,Vector2.RIGHT * w * MazeDefine.gridSize,wallColor,3)
	draw_line(Vector2.ZERO,Vector2.DOWN * h * MazeDefine.gridSize,wallColor,3)
	for y in h:
		for x in w:
			var pos = Vector3(x,y,0)
			var loc = rot3D.to_local(pos)
			var xDir = rot3D.to_local(renderVectorX)
			var yDir = rot3D.to_local(renderVectorY)
			if maze.GetWall(loc.x,loc.y,loc.z,0) != '.':
				drawHWall(x,y)
			if maze.GetWall(loc.x,loc.y,loc.z,2) != '.':
				drawVWall(x,y)

func drawHWall(x,y):
	draw_line(Vector2(x+1,y)*MazeDefine.gridSize-Vector2(0,1.5),
	Vector2(x+1,y+1)*MazeDefine.gridSize + Vector2(0,1.5),wallColor,3)
	
func drawVWall(x,y):
	draw_line(Vector2(x,y+1)*MazeDefine.gridSize-Vector2(1.5,0),
	Vector2(x+1,y+1)*MazeDefine.gridSize + Vector2(1.5,0),wallColor,3)
