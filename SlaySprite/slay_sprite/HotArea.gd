extends Control

func get_drag_data(position):
	var card = get_parent()
	var curser = load("res://DragCurser.tscn").instance()
	var ori_position = get_parent().rect_position + get_parent().get_parent().rect_position
	curser.Set(ori_position)
	force_drag(card,curser)
	return card
