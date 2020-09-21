extends Control

signal select()

func Set(slot_dat):
	if slot_dat.slot == null:
		$Icon.texture = load("res://images/icon/icon_add.png")
	else:
		$Icon.texture = load(slot_dat.slot.icon)
		if slot_dat.slot.get("ammo",-1)!=-1:
			$Icon/ammo.text = "%d/%d"%[slot_dat.slot.ammo,slot_dat.slot.ammo_cap]
			$Icon/ammo.show()
		else:
			$Icon/ammo.text = ""
			$Icon/ammo.hide()

func _on_SelectEquipmentIcon_gui_input(event):
	if event is InputEventMouseButton && event.button_index == 1 && event.pressed:
		emit_signal("select")
