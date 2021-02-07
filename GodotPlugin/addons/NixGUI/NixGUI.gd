tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("OptionLabel","RichTextLabel",
		preload("OptionLabel.gd"),preload("icon/icon_option_label.svg"))
	add_autoload_singleton("GlbUI","res://addons/NixGUI/GlbUI.tscn")

func _exit_tree():
	remove_autoload_singleton("GlbUI")
	remove_custom_type("OptionLabel")
