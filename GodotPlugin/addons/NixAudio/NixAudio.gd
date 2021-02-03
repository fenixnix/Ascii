tool
extends EditorPlugin

var path = "res://addons/NixAudio/"

func _enter_tree():
	ProjectSettings["audio/default_bus_layout"] = path + "AudioBus.tres"
	add_autoload_singleton("GlbAudio",path + "GlbAudio.gd")

func _exit_tree():
	remove_autoload_singleton("GlbAudio")
	ProjectSettings["audio/default_bus_layout"] = ""
