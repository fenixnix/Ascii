tool
extends EditorPlugin

var dock

func _enter_tree():
	var dock = preload("res://addons/NixLib/Message.tscn").instance()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UR,dock)
	add_custom_type("MyButton", "Button", preload("button.gd"), preload("icon.png"))

func _exit_tree():
	remove_custom_type("MyButton")
	remove_control_from_docks(dock)
	dock.free()
