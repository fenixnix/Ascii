extends PopupMenu

signal selected(itemIndex)

func Open(list,pos = Vector2.ZERO):
	clear()
	for l in list:
		add_item(l)
	#var size = Vector2(120,30*$BldLst.get_item_count())
	popup(Rect2(pos,Vector2.ONE))

func _on_PopupList_index_pressed(index):
	emit_signal("selected",index)
