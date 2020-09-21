extends Control

onready var buildList = $Build/HBoxContainer/BuildList/List

var data
var current_dat

func Set(fcty):
	data = fcty
	buildList.clear()
	for w in GlbDb.eqpDB:
		buildList.add_item(w.name,load(w.get('icon','res://images/icon/icon_brace.png')))
	_on_List_item_selected(0)

func _on_List_item_selected(index):
	current_dat = GlbDb.eqpDB[index]
	$Build/HBoxContainer/EqpBuildInfoRT.Set(current_dat)

func _on_OK_pressed():
	if current_dat!=null:
		if !data.has("task"):
			data.task = []
		data.task.append({
			"item":current_dat,
			"progress":0
		})

func _on_Queue_item_activated(index):
	#_on_OK_pressed()
	pass

func _on_List_item_activated(index):
	_on_OK_pressed()
