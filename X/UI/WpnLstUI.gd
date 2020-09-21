extends Control

var data

signal select(weapon)

func Set(dat):
	data = dat
	$ItemList.clear()
	for w in dat:
		$ItemList.add_item(w.name,load(w.get('icon',"res://images/icon/icon_dice.png")))

func _on_Close_pressed():
	emit_signal("select",null)
	GlbUi.Pop()

func _on_ItemList_item_selected(index):
	$WpnInfo.Set(data[index])

func _on_ItemList_item_activated(index):
	emit_signal("select",data[index])
	GlbUi.Pop()	
