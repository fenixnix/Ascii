tool
extends EditorPlugin

var path = "res://addons/NixStory/"

func _enter_tree():
	add_autoload_singleton("Narrative",path + "Narrative.tscn")
	add_autoload_singleton("Dialog",path + "Dialog.tscn")
	add_autoload_singleton("Scene",path + "Scene.tscn")
	add_custom_type("NixStoryPlayer","Node",load(path + "NixStoryPlayer.gd"),preload("icon/icon_print_text.svg"))

func _exit_tree():
	remove_autoload_singleton("Narrative")
	remove_autoload_singleton("Dialog")
	remove_autoload_singleton("Scene")
	remove_custom_type("NixStoryPlayer")
