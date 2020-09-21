extends Control

export(PackedScene) var shipLabelPrefab

var data

func Set(ships_dat):
	data = ships_dat
	refresh(ships_dat)
	show()

func refresh(ships):
	for c in $VBoxContainer/ScrollContainer/List.get_children():
		c.queue_free()
	for s in ships:
		var lab = shipLabelPrefab.instance()
		$VBoxContainer/ScrollContainer/List.add_child(lab)
		lab.Set(s)
		lab.connect("select",self,"on_select_ship")
		lab.connect("value_change",self,"on_value_change")
	if len(ships)>0:
		$ShipConfigUI.Set(ships[0])

func on_select_ship(data):
	$ShipConfigUI.Set(data.data)

func on_value_change(_data):
	refresh(data)

func _on_Close_pressed():
	GlbUi.Pop()
