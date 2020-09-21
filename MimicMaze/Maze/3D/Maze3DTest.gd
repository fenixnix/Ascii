extends Node

var location = Vector2.ZERO

onready var avatar = $Avatar
onready var cube = $Draw3D/Center/Cube
onready var center = $Draw3D/Center

func _ready():
	print(Vector3(3,4,5).dot(Vector3(0,1,0)))
	
	#var mazeGen = DepthFirst3D.new()
	var mazeGen = Prim3D.new()
	var maze = mazeGen.Gen([0,0,0],[8,8,4])
	maze.Print()
	$Draw.maze = maze
	$Draw3D/Center/Cube.Set(maze)
	$Draw.update()
	

func _input(event):
		
	if event.is_action_pressed("Left"):
		avatar.move_local_x(-1*MazeDefine.gridSize)
		cube.global_translate(Vector3.LEFT)
	if event.is_action_pressed("Right"):
		avatar.move_local_x(1*MazeDefine.gridSize)
		cube.global_translate(Vector3.RIGHT)
	if event.is_action_pressed("Up"):
		avatar.move_local_y(-1*MazeDefine.gridSize)
		cube.global_translate(Vector3.UP)
	if event.is_action_pressed("Down"):
		avatar.move_local_y(1*MazeDefine.gridSize)
		cube.global_translate(Vector3.DOWN)
	
	if event.is_action_pressed("RLeft"):
		center.global_rotate(Vector3.UP,PI/2)
		$Draw3D/Center/Cube.Refresh()
		
	if event.is_action_pressed("RRight"):
		center.global_rotate(Vector3.UP,-PI/2)
		$Draw3D/Center/Cube.Refresh()
		

	if event.is_action_pressed("RUp"):
		center.global_rotate(Vector3.RIGHT,PI/2)
		$Draw3D/Center/Cube.Refresh()
		
	if event.is_action_pressed("RDown"):
		center.global_rotate(Vector3.RIGHT,-PI/2)
		$Draw3D/Center/Cube.Refresh()

	$Draw.update()
	#print(cube.to_local(Vector3(-5,5,0)))
