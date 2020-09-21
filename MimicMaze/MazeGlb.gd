extends Node

var unlockLevel = 50
var levelDb = []

func _ready():
	var file = File.new()
	file.open("res://level.json",File.READ)
	var dat = file.get_as_text()
	levelDb = parse_json(dat)
	file.close()
	print(levelDb)

func Save():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line({"levelUnlock":unlockLevel})

func UITitleMenu():
	GlbAudio.PlayUISfx("res://Audio/UI/back_002.ogg")
	var titleMenu = load("res://UI/TitleMenu.tscn")
	var menu = titleMenu.instance()
	add_child(menu)
	menu.connect("new_game",self,"on_new_game")

func UILevelSelection():
	var levelSelection = load("res://UI/LevelSelection.tscn").instance()
	add_child(levelSelection)
	levelSelection.connect("sel_level",self,"on_gen_maze",[0])

func UIMazeOption():
	var mazeOption = load("res://UI/MazeOption.tscn").instance()
	add_child(mazeOption)
	mazeOption.connect("gen_maze",self,"on_gen_maze",[1])

func on_new_game(mode):
	match mode:
		0:UILevelSelection()
		1:UIMazeOption()

func on_gen_maze(dat,mode):
	print("gen:",dat)
	var map = load("res://Maze/MazeMap.tscn").instance()
	add_child(map)
	var data = dat.duplicate(true)
	data.mode = mode
	map.NewGame(data)
