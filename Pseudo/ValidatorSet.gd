extends VBoxContainer

var data = {"id":0,"set":[]}

signal selected(dat)
signal remove_shard(index)

func Set(dat):
	data = dat
	Refresh()
	
func Refresh():
	$Menu/ID.value = data.get("id",0)
	$List.clear()
	for s in data.get("set",[]):
		$List.add_item(s)

func _on_List_focus_entered():
	print("selected:",data.get("id",0))
	emit_signal("selected",self)

func _on_List_item_rmb_selected(index, at_position):
	var pop = PopupMenu.new()
	add_child(pop)
	pop.add_check_item("Remove")
	pop.popup(Rect2(at_position,Vector2.ONE))
	var selIndex = yield(pop,"index_pressed")
	match selIndex:
		0:data["set"].remove(index)
		_:pass
	pop.queue_free()
	Refresh()

func _on_Close_pressed():
	emit_signal("remove_shard",data.get("id",0))
	queue_free()
