extends Node2D

export var team = 1
export var hp = 1
export var armor = 0

func _ready():
	Init()

func Init():
	pass

func on_destory():
	get_parent().queue_free()
