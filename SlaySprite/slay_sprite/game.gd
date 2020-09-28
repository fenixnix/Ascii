extends Node

var chara

onready var battle_prefab = preload("res://battle.tscn")

func _ready():
	chara = Chara.new()
	chara.Set(GlbDb.LoadDat("ironclad_default"))
	var battle = battle_prefab.instance()
	add_child(battle)
	battle.Start({
		"chara":chara
	})

