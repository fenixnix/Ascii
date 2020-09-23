extends Node2D

onready var location_prefab = preload("res://Location.tscn")

func AddLocation(id):
	var loc = location_prefab.instance()
	add_child(loc)
	loc.Set(GlbDb.locDb[id])

func Enter(chara,id):
	get_node(str(id)).chara.append(chara)
