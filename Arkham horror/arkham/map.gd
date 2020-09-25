extends Node2D

onready var location_prefab = preload("res://Location.tscn")

func AddLocation(id):
	var loc = location_prefab.instance()
	add_child(loc)
	loc.Set(GlbDb.locDb[id])

func SetLocation(loc_id_list):
	for c in get_children():
		c.queue_free()
	for l in loc_id_list:
		AddLocation(l)

func Enter(chara,id):
	var loc = get_node(str(id))
	loc.Enter(chara)

func SetupAction(chara):
	for c in get_children():
		c.SetActionType("")
	if chara.at<=0:
		return
	for c in get_children():
		if c.chara.has(chara):
			if c.clue>0:
				c.SetActionType("scan")
			for negh in c.data.connect:
				get_node("%s"%negh).SetActionType("move")

func Refresh():
	for c in get_children():
		c.refresh()
