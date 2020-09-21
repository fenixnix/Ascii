extends VBoxContainer

onready var list = $ScrollContainer/ItemList

signal buy(itm_id)

var currentSite:Site

func Open(site):
	currentSite = site
	Refresh()
	show()

func Refresh():
	$HBoxContainer/Label.text = currentSite.name_text
	list.clear()
	yield(get_tree(),"idle_frame")
	for p in currentSite.shopList:
		var dat = GlbDb.itmDb[p.id]
		list.add_item("[%s] * %3d --> (%d)%d$"%[dat.name,p.cnt,dat.price,currentSite.RecommandPrice(p.id)*1.1])
		list.set_item_tooltip(list.get_item_count()-1,"%s\n============\nStack:%d\nWt:%d\n%d$"%[dat.name,dat.stack,dat.wt,dat.price])

func _on_Close_pressed():
	hide()

func _on_ItemList_item_activated(index):
	emit_signal("buy",index)
	
