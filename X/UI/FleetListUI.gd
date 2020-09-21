extends Control

var shipLabPrefab = preload("res://UI/ShipLabelUI.tscn")
var current_fleet
var site_data

signal select(fleet)

func Set(site_dat):
	site_data = site_dat
	if len(site_data.fleets)>0:
		current_fleet = site_data.fleets[0]
	Refresh()
	if len(site_data.fleets)>0:
		current_fleet = site_data.fleets[0]
		$Fleet/Name.text = current_fleet.name
		$FleetList/FleetList.select(0)

func Refresh():
	refresh_fleet()
	refresh_shiplist()
	refresh_ships()

func refresh_fleet():
	$FleetList/FleetList.clear()
	for f in site_data.fleets:
		$FleetList/FleetList.add_item(f.name)

func refresh_ships():
	print(current_fleet)
	for c in $Fleet/ScrollContainer/ShipList.get_children():
		c.queue_free()
	if current_fleet!=null:
		for s in current_fleet.ships:
			var lab = shipLabPrefab.instance()
			lab.Set(s)
			$Fleet/ScrollContainer/ShipList.add_child(lab)
			lab.connect("select",self,"on_select_fleet_ship")

var current_fleet_current_ship
func on_select_fleet_ship(ship):
	current_fleet_current_ship = ship.data

onready var shiplist = $Ships/ShipList
func refresh_shiplist():
	shiplist.clear()
	for ship in site_data.ships:
		shiplist.add_item(ship.name)

func _on_Cancel_pressed():
	GlbUi.Pop()

func _on_OK_pressed():
	GlbUi.Pop()
	emit_signal("select",current_fleet)

func _on_FleetList_item_selected(index):
	current_fleet = site_data.fleets[index]
	refresh_ships()

func _on_Name_text_changed(new_text):
	current_fleet.name = new_text
	refresh_fleet()

func _on_new_fleet_pressed():
	site_data.SetFleet({"name":"fleet name","team":0,"ships":[]})
	refresh_fleet()

func _on_dissmiss_fleet_pressed():
	for ship in current_fleet.ships:
		site_data.ships.append(ship)
	site_data.fleets.erase(current_fleet)
	if len(site_data.fleets)>0:
		current_fleet = site_data.fleets[0]
	else:
		current_fleet = null
	refresh_ships()
	refresh_fleet()
	refresh_shiplist()

func _on_ShipList_item_activated(index):
	current_fleet.ships.append(site_data.ships[index])
	site_data.ships.remove(index)
	refresh_ships()
	refresh_shiplist()

func _on_add_pressed():
	for sel in $Ships/ShipList.get_selected_items():
		_on_ShipList_item_activated(sel)

func _on_ShipList_item_selected(index):
	$Ships/ShipAbstract/Info.Set(site_data.ships[index])

func _on_rmv_pressed():
	if current_fleet_current_ship==null:
		return
	site_data.ships.append(current_fleet_current_ship)
	current_fleet.ships.erase(current_fleet_current_ship)
	refresh_ships()
	refresh_shiplist()
