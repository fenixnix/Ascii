extends Node2D

func _process(delta):
	global_position = get_parent().position + (get_global_mouse_position()-get_parent().position)/3
