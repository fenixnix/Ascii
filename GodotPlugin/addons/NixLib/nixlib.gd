tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("DateTimeLabel","Label",preload("DateTime.gd"),preload("icon/icon_datetime.svg"))
	pass

func _exit_tree():
	remove_custom_type("DateTimeLabel")
	pass
