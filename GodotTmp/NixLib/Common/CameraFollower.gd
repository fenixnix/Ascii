extends Node2D

var target

func _process(delta):
	if is_instance_valid(target):
		position = target.global_position
