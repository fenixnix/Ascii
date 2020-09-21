extends Control

var data

onready var wpn_lst = $HBox/VBox/ShipConfig/Weapon/WeaponList
onready var eqp_lst = $HBox/VBox/ShipConfig/Equipment/GearList

func Set(_data):
	data = _data
	$HBox/VBox/ShipConfig/ShipName.text = data.name
	$HBox/VBox2/ShipInfoRT.Set(data)
	refresh_officer()
	refresh_wpns()
	for c in eqp_lst.get_children():
		c.queue_free()
	add_icons(data.eqps,"eqp",eqp_lst)
	
	#$AnimationPlayer.play("UI_Enter_Top")

func refresh_officer():
	if data.get("ofc",null)!=null:
		$HBox/VBox/Officer/OfcInfoRT.Set(data.ofc)
	else:
		$HBox/VBox/Officer/OfcInfoRT.clear()
		$HBox/VBox/Officer/OfcInfoRT.append_bbcode("No Officer")

func refresh_wpns():
	for c in wpn_lst.get_children():
		c.queue_free()
	add_icons(data.wpns,"weapon",wpn_lst)
	

func add_icons(list,type,node):
	var icon_prefab = load("res://UI/SelectEquipmentIcon.tscn")
	for i in range(len(list)):
		var icon = icon_prefab.instance()
		icon.Set(list[i])
		icon.connect("select",self,"on_select_slot",[type,i])
		node.add_child(icon)

func on_select_slot(type,index):
	match type:
		"weapon":
			if GlbDat.currentSite!=null:
				var ui = GlbUi.PushUI("WpnLstUI",GlbDat.currentSite.wpns)
				var res = yield(ui,"select")
				var old = data.wpns[index].slot
				if old!=null:
					GlbDat.currentSite.wpns.append(old)
				data.wpns[index].slot = res
				GlbDat.currentSite.wpns.erase(res)
				refresh_wpns()
		"gear":
			pass

func _on_ShipName_text_changed(new_text):
	data.name = new_text

func on_select_officer(officer):
	data.ofc = officer
	refresh_officer()
