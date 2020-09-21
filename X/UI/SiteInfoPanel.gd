extends Control

var data

func Set(dat):
	data = dat
	$Panel/ScrollContainer/Info.Set(data)

func _on_Exit_pressed():
	GlbUi.Pop()
	
func _on_Launch_pressed():
	var ui = GlbUi.PushUI("FleetListUI",data)
	ui.connect("select",self,"on_select_launch_fleet")

func _on_Ship_pressed():
	var list = []
	for s in data.ships:
		list.append(s)
	for f in data.fleets:
		for s in f.get("ships",[]):
			list.append(s)
	GlbUi.PushUI("ShipUI",list)

func _on_Weapons_pressed():
	GlbUi.PushUI("WpnLstUI",data.wpns)

func _on_Region_pressed():
	GlbUi.PushUI("RegionUI",data)

func _on_Officer_pressed():
	GlbUi.PushUI("OfficerUI",data.ofcs)

func on_select_launch_fleet(fleet):
	$"/root/Main".SelectSiteToLaunchFleet(data,fleet)
	GlbUi.PushUI("SelectSiteUI","null")

func _on_Info_visibility_changed():
	$Panel/ScrollContainer/Info.Set(data)
