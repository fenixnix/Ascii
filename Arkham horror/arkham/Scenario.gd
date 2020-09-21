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
	$progress/act/OptionButton.clear()
	for act in current_ect.act:
		$progress/act/OptionButton.add_item(act.name)
	$progress/agenda/OptionButton2.clear()
	for agenda in current_ect.agenda:
		$progress/agenda/OptionButton2.add_item(agenda.name)
	_on_OptionButton_item_selected(0)
	$Location/locLst.clear()
	for loc in current_ect.loc:
		$Location/locLst.add_item(loc.name)
	_on_OptionButton2_item_selected(0)
	
func _on_locLst_item_selected(index):
	$Location/Location.texture = GlbDb.CardImg(current_ect.loc[index].img)

func _on_OptionButton_item_selected(index):
	$progress/act/TextureRect.texture = GlbDb.CardImg(current_ect.act[index].img)

func _on_OptionButton2_item_selected(index):
	$progress/agenda/TextureRect2.texture = GlbDb.CardImg(current_ect.agenda[index].img)

func _on_OptionButton2_item_focused(index):
	$progress/agenda/TextureRect2.texture = GlbDb.CardImg(current_ect.agenda[index].img)

func _on_OptionButton_item_focused(index):
	$progress/act/TextureRect.texture = GlbDb.CardImg(current_ect.act[index].img)

func _on_Button_pressed():
	queue_free()

func _on_scenario_sel_mouse_entered():
	$scenario/TextureRect.show()

func _on_scenario_sel_mouse_exited():
	$scenario/TextureRect.hide()
