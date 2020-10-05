extends Node


onready var battle_prefab = preload("res://battle.tscn")

func _ready():
	seed(OS.get_system_time_msecs())
	GlbDat.chara = Chara.new()
	GlbDat.chara.Set(GlbDb.LoadDat("ironclad_default"))
	
	GlbDat.currentLevel = 0
	GlbDat.map = FileRW.LoadJsonFile("res://data/map/map01.json")
	
	var battle = battle_prefab.instance()
	add_child(battle)
	battle.Start({
		"chara":GlbDat.chara,
		"enm":["goblin"]
	})
