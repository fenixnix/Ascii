extends Sprite

export var shadow_offset = Vector2.ZERO

func _process(delta):
	global_position = get_parent().position + shadow_offset
