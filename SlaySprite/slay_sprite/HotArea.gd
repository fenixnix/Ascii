extends Control

func get_drag_data(position):
	print("drag",position)
	return get_parent()

#func drop_data(position, data):
#	print("hot drop",position,data)
#
#func can_drop_data(position, data):
#	print("hot can_drop")
#	return true
