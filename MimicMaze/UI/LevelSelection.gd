extends Control

onready var root = $ScrollContainer/GridContainer
var lockIcon = preload("res://Image/locked.png")

signal sel_level(dat)

func _ready():
	var index = 0
	for l in MazeGlb.levelDb:
		var btn = Button.new()
		btn.connect("pressed",self,"on_select",[index])
		if index>MazeGlb.unlockLevel:
			btn.icon = lockIcon
			btn.disabled = true
		btn.text = str(index+1)
		root.add_child(btn)
		index+=1

func on_select(index):
	var data = MazeGlb.levelDb[index].duplicate(true)
	print(data)
	data.mode = 0
	data.lv = index
	emit_signal("sel_level",data)
	queue_free()

func _on_Back_pressed():
	MazeGlb.UITitleMenu()
	queue_free()
