extends Node

var avatarPrefab = preload("res://TopDownShootGame/Avatar.tscn")
var avatar

func _ready():
	InitGame()

func InitGame():
	avatar = avatarPrefab.instance()
	avatar.connect("dead",self,"_on_Avatar_dead")
	add_child(avatar)
	avatar.position = $Stage/SpawnPoint.position
	var sight = avatar.get_node("SightCenter")
	$Camera.target = sight

func _on_Avatar_dead():
	print_debug()
	$GUI/DeadMenu.visible = true

func _on_VBoxContainer_pressed(id):
	$GUI/DeadMenu.hide()
	match id:
		"Retry":InitGame()
		_:InitGame()

func _on_Button_pressed():
	$Camera/Camera2D_Zoom/CameraShake.Shake(64)
