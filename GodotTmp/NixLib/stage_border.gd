tool
extends StaticBody2D

class_name StageBorder

export var gridSize = Vector2.ONE*64
export var left = 0
export var right = 64
export var top = -64
export var bottom = 0

var corners = {}
var drawColor = Color.red

func _ready():
	init()
	Clear()
	MakeBorder()
	var node = get_tree().current_scene.find_node("Camera2D_Zoom")
	if node!=null:
		SetCameraBorder(node)

func init():
	corners[0] = Vector2(left,top)*gridSize
	corners[1] = Vector2(right,top)*gridSize
	corners[2] = Vector2(left,bottom)*gridSize
	corners[3] = Vector2(right,bottom)*gridSize

func Clear():
	for c in get_children():
		c.queue_free()

func SetCameraBorder(cam:Camera2D):
	cam.limit_left = left*gridSize.x
	cam.limit_right = right*gridSize.x
	cam.limit_top = top*gridSize.y
	cam.limit_bottom = bottom*gridSize.y

func MakeBorder():
	MakeBlockWall(corners[0],corners[1])
	MakeBlockWall(corners[2],corners[3])
	MakeBlockWall(corners[0],corners[2])
	MakeBlockWall(corners[1],corners[3])

func MakeBlockWall(A,B):
	#var body = StaticBody2D.new()
	var coll = CollisionShape2D.new()
	var shape = SegmentShape2D.new()
	shape.a = A
	shape.b = B
	coll.shape = shape
	#body.add_child(coll)
	add_child(coll)

func _process(delta):
	if Engine.editor_hint:
		update()
	
func _draw():
	if Engine.editor_hint:
		init()
		draw_line(corners[0],corners[1],drawColor,3)
		draw_line(corners[2],corners[3],drawColor,3)
		draw_line(corners[0],corners[2],drawColor,3)
		draw_line(corners[1],corners[3],drawColor,3)
