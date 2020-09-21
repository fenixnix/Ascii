extends Control

var current_ect

func _ready():
	$scenario/scenario_sel.clear()
	for s in GlbDb.ectDb.keys():
		$scenario/scenario_sel.add_item(s)
	_on_scenario_sel_item_selected(0)

func _on_scenario_sel_item_selected(index):
	current_ect = GlbDb.ectDb[GlbDb.ectDb.keys()[index]]
	$scenario/TextureRect.texture = GlbDb.CardImg(current_ect.scenario.img)
	$progress.Set(current_ect)
	$Location/locLst.clear()
	for loc in current_ect.loc:
		$Location/locLst.add_item(loc.name)
	
func _on_locLst_item_selected(index):
	$Location/Location.texture = GlbDb.CardImg(current_ect.loc[index].img)



func _on_Button_pressed():
	queue_free()

func _on_scenario_sel_mouse_entered():
	$scenario/TextureRect.show()

func _on_scenario_sel_mouse_exited():
	$scenario/TextureRect.hide()

func _on_Button2_toggled(button_pressed):
	$progress.visible = button_pressed
