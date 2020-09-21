extends Control

export(PackedScene) var menuPrefab = preload("res://TowerDefence/HUD/PopupList.tscn")

signal select_action(action)

func SelectGrid(gridID):
	var lst = TT(gridID)
	if len(lst)>0:
		return Select(lst,get_global_mouse_position())
	return null

func TT(id):
	match id:
		"base":return TdGlb.tower_types
		"empty":return[]
	return["fireRate","range","power","demount"]

func Select(lst,pos):
	var menu = menuPrefab.instance()
	add_child(menu)
	menu.Open(lst,pos)
	var index = yield(menu,"selected")
	#print(lst[index])
	emit_signal("select_action",lst[index])
	menu.queue_free()
