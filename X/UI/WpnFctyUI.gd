extends Control

onready var buildList = $Build/HBoxContainer/BuildList/List

var data
var current_dat

func Set(fcty):
	data = fcty
	buildList.clear()
	for w in GlbDb.wpnDB:
		buildList.add_item(w.name,load(w.get('icon','')))
	_on_List_item_selected(0)
	refresh_build_statues()
	refresh_queue()


func refresh_build_statues():
	if data.has("task") && len(data.task)>0:
		$Build/HBoxContainer/BuildList/BuildStatus.Set({
			"name":data.task[0].item.name,
			"img":data.task[0].item.icon,
			"progress":data.task[0].progress
		})

onready var queue = $Build/HBoxContainer/BuildList/Queue/Queue
func refresh_queue():
	if data.has("task"):
		queue.clear()
		for t in data.task:
			queue.add_item(t.item.name,load(t.item.icon))

func _on_List_item_selected(index):
	current_dat = GlbDb.wpnDB[index]
	$Build/HBoxContainer/WpnBuildInfoRT.Set(current_dat)

func _on_OK_pressed():
	if current_dat!=null:
		if !data.has("task"):
			data.task = []
		data.task.append({
			"item":current_dat,
			"progress":0
		})
	refresh_build_statues()
	refresh_queue()

func _on_List_item_activated(index):
	_on_OK_pressed()
	
