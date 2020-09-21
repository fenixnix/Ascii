extends VBoxContainer

onready var list = $Inventory/ItemList

var inventory

signal sell(index)

func Open(_inventory):
	inventory = _inventory
	Refresh()
	show()

func Refresh():
	list.clear()
	for i in inventory:
		var dat = GlbDb.itmDb[i.id]
		list.add_item("[%s]*%d"%[dat.name,i.cnt])

func _on_Close_pressed():
	hide()

func _on_ItemList_item_activated(index):
	emit_signal("sell",index)
