extends Node

func _ready():
	GlbAudio.PlayBGM("res://Audio/underwater.ogg")
	var titleMenu = load("res://UI/TitleMenu.tscn")
	var menu = titleMenu.instance()
	add_child(menu)
	menu.connect("new_game",MazeGlb,"on_new_game")
