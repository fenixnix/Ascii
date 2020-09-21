extends Node2D

var heart = 100
var heartMax = 100
var shield = 0
var shieldMax = 20
var movSpd = .5
var viewRange = 2

var stepCnt = 0

var location = [0,0,0]
var offset

onready var label = $HUD/Root/HBoxContainer/Label
var box = preload("res://Maze/Player.tres")

func _ready():
	RefreshHUD()

func SetPos(loc):
	location = loc
	offset = Vector2.ONE* MazeDefine.gridSize/2
	var pos = Vector2(loc[0],loc[1])*MazeDefine.gridSize + offset
	position = Vector2(pos[0],pos[1])

func AvatarPos():
	return Vector3(location[0],location[1],location[2])

func Move(ref_pos):
	stepCnt += 1
	location[0]+= ref_pos.x
	location[1]+= ref_pos.y
	location[2]+= ref_pos.z
	MoveTo(Vector2(location[0],location[1])*MazeDefine.gridSize + offset)

func MoveTo(pos:Vector2):
	var dstPos = pos.snapped(Vector2.ONE*MazeDefine.gridSize)-Vector2.ONE*MazeDefine.gridSize/2
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self,"position",position,dstPos,movSpd,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.start()
	yield(tween,"tween_all_completed")
	tween.queue_free()
	heart -= 1
	RefreshHUD()
	get_parent().Explore(viewRange)

func TakeDamage(dmg):
	var d = sldTakeDmg(dmg)
	heart -= d
	if heart<=0:
		heart = 0
	
func sldTakeDmg(dmg):
	var res = shield - dmg
	if res<0:
		return -res
	return 0

func RefreshHUD():
	#label.text = "HP:%d/%d\nSHD:%d/%d\nStep:%d"%[heart,heartMax,shield,shieldMax,stepCnt]
	label.text = "Step:%d"%[stepCnt]

var boxSize = 16
func _draw():
	draw_style_box(box,Rect2(-boxSize/2,-boxSize/2,boxSize,boxSize))
