extends Control

var data

var shipList = []
var currentShip = null

signal build_ship(ship)

func Set(dat):
	data = dat
	$HBoxContainer/VBoxContainer/ItemList.clear()
	shipList.clear()
	for ship in GlbDb.shipDB:
		if ship.info.tier <= data.tier:
			shipList.append(ship)
			$HBoxContainer/VBoxContainer/ItemList.add_item(ship.name)
	currentShip = shipList[0]
	$HBoxContainer/ShipBuildInfoRT.Set(currentShip)
	refresh_queue(dat)
	show()

onready var queue = $HBoxContainer/VBoxContainer/Queue

func refresh_queue(dat):
	if dat.has("task")&&len(dat.task)>0:
		var firstTask = dat.task[0]
		$HBoxContainer/VBoxContainer/BuildStatus.Set({"name":firstTask.item.name,
		"img":firstTask.item.img,
		"progress":firstTask.progress
		})
		queue.clear()
		for t in data.task:
			queue.add_item(t.item.name)
	else:
		$HBoxContainer/VBoxContainer/BuildStatus.hide()

func _on_ItemList_item_selected(index):
	currentShip = shipList[index]
	$HBoxContainer/ShipBuildInfoRT.Set(currentShip)	

func _on_OK_pressed():
	if currentShip == null:
		print_debug("null ship data")
		return
	if !data.has("task"):
		data.task = []
	data.task.append({"item":currentShip,"progress":0})
	GlbDat.currentSite.TakeResource(currentShip.cost)
	emit_signal("build_ship",currentShip)
	refresh_queue(data)


func _on_ItemList_item_activated(index):
	_on_OK_pressed()
