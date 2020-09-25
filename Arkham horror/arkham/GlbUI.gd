extends CanvasLayer

signal select_option(index)

func Select(option_list):
	$ItemList.clear()
	for o in option_list:
		$ItemList.add_item(o)
	$ItemList.show()

func _on_Choice_meta_clicked(meta):
	emit_signal("select_option",meta)

func _on_ItemList_item_activated(index):
	emit_signal("select_option",index)
	$ItemList.hide()
