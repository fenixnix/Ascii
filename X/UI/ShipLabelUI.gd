extends PanelContainer

signal select(data)
signal value_change(data)

var data

func Set(dat):
	data = dat
	refresh()

func refresh():
	$ShipLabelRT.Set(data)
	if data.has("ofc"):
		$ShipLabelRT/Pilot.texture = load(data.ofc.icon)
	else:
		$ShipLabelRT/Pilot.texture = load(GlbDb.default_officer_portrait)

func _on_ShipLabelUI_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1&&event.pressed:
			emit_signal("select",self)
			Set(data)

func _on_Pilot_gui_input(event):
	if event.is_action_pressed("click"):
		var ui = GlbUi.OverlapUI("OfcSelUI",GlbDat.currentSite.ofcs)
		var ofc = yield(ui,"select")
		if data.has("ofc"):
			data.ofc.erase("ship")
		if ofc == null:
			data.erase("ofc")
		else:
			if ofc.has("ship"):
				ofc.ship.erase("ofc")
			data.ofc = ofc
			ofc.ship = data
		refresh()
		emit_signal("value_change",data)
