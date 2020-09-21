extends Node

class_name TowerAI

onready var tower = get_parent()

func _process(delta):
	tower.Shoot()
