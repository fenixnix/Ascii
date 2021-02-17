tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("GlbUI","res://addons/NixGUI/GlbUI.tscn")

func _exit_tree():
	remove_autoload_singleton("GlbUI")
