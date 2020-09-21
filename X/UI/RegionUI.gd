extends Control

onready var region_list = $Region/RegionList

var data
var regions
var currentRegion
var currentFacility
var currentFacilityUI = null

func _ready():
	$State/NoFacility/BuildFacilityUI.connect("select",self,"on_select_build_facility")	

func Set(_data):
	data = _data
	regions = data.regions
	var region_list = $Region/RegionList
	region_list.clear()
	for r in regions:
		var desc = r.name
		if r.facility!=null:
			desc += ":%s"%r.facility.name
		region_list.add_item(desc,load(status_icon(check_region_status(r))))
	refresh_res(data)

func status_icon(status):
	match status:
		"unexplored","exploring":return "res://images/icon/icon_caution.png"
		"openspace","building":return "res://images/icon/icon_exclamation.png"
		"occupid":return "res://images/icon/icon_system_unique.png"
		_:return "res://images/icon/icon_system_unique.png"

func _on_RegionList_item_selected(index):
	currentRegion = regions[index]
	$BG.texture = load(currentRegion.img)
	refresh_ui()

func check_region_status(region):
	if region.has("explore"):
		if region.explore.running:
			return "exploring"
		else:
			return "unexplored"
	elif region.facility == null: 
		if region.has("building"):
			return "building"
		else:
			return "openspace"
	else:
		return "occupied"

func refresh_ui():
	var status = check_region_status(currentRegion)
	match status:
		"exploring":$State/Exploring.Set(currentRegion.explore)
		"unexplored":$State/UnExplored.Set(currentRegion.explore)
		"building":$State/Building.Set(currentRegion.building)
		"openspace":
			var lst = FileRW.LoadJsonFile("res://data/fclt.json")
			$State/NoFacility/BuildFacilityUI.Set(lst)
		"occupied":
			$State/Occupied/Info.clear()
			for c in $State/Occupied/Root.get_children():
				c.queue_free()
			currentFacility = currentRegion.facility
			match currentFacility.type:
				"ofc_fcty":ShowFacilityUI("OfcFctyUI")
				"ship_fcty":ShowFacilityUI("ShipyardUI")
				"wpn_fcty":ShowFacilityUI("WpnFctyUI")
				"eqp_fcty":ShowFacilityUI("EqpFctyUI")
				"research":ShowFacilityUI("ResearchUI")
				"market":ShowFacilityUI("MarketUI")
				_:$State/Occupied/Info.Set(currentRegion.facility)
	$State.Set(status)
	refresh_res(data)

func refresh_res(data):
	$"status&resources".bbcode_enabled = true
	$"status&resources".bbcode_text = """
 [color=yellow]%s %d/%d[/color]
 [color=#00ffff]TECH:%d[/color]
 [color=#ffff00]INDU:%d[/color]
%s"""%[
		GlbDb.FontIcon("power"),
		Region.CostPower(data.regions),
		Region.GenPower(data.regions),
		data.tech,
		data.indu,
		BBCode.resource_vert(data.res)
	]

func ShowFacilityUI(ui_filename):
	var ui = load("res://UI/%s.tscn"%ui_filename).instance()
	$State/Occupied/Root.add_child(ui)
	ui.Set(currentFacility)

func on_region_explore():
	pass

func on_select_build_facility(fclt_dat):
	GlbDat.currentSite.TakeResource(fclt_dat.cost)
	var building = fclt_dat.duplicate(true)
	building.erase('cost')
	building.progress = 0
	building.title = "Build Facility: %s"%building.name
	currentRegion.building = building
	refresh_ui()

func _on_ExploreBtn_pressed():
	currentRegion.explore.running = true
	refresh_ui()

func _on_ExploreCancelBtn_pressed():
	currentRegion.explore.running = false
	currentRegion.explore.progress = 0
	refresh_ui()

func _on_Close_pressed():
	GlbUi.Pop()

func _on_AssignOfficer_pressed():
	var ui = GlbUi.PushUI("OfcSelUI",GlbDat.currentSite.ofcs)
	ui.connect("select",self,"on_select_explore_officer")

func on_select_explore_officer(officer):
	$State/UnExplored/AssignOfficer.icon = load(officer.icon)
	currentRegion.ofc = officer
	print_debug(officer)

func regionExploreTime():
	var time = Officer.TimeReduce(currentRegion.ofc,currentRegion.explore.needs)*currentRegion.explore.time

func _on_UnExplored_execute(data):
	data.running = true
	$State/Exploring.Set(data)
	refresh_ui()

func _on_Exploring_cancel_task(data):
	data.running = false
	data.progress = 0
	refresh_ui()

func _on_Building_cancel_task(data):
	currentRegion.erase("building")
	refresh_ui()
