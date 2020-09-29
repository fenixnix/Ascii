extends Control

var active = true

func get_drag_data(position):
	if active:
		var card = get_parent()
		var curser = load("res://DragCurser.tscn").instance()
		var ori_position = get_parent().rect_position + get_parent().get_parent().rect_position
		curser.Set(ori_position)
		force_drag(card,curser)
		return card

func _on_HotArea_gui_input(event):
	if event.is_action_pressed("click") && event.doubleclick:
		var card = get_parent().data
		if card.type!="Attack":
			GlbAct.PlayCard(card)
