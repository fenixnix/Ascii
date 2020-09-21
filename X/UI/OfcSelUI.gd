extends Control

var data
var currentIndex = 0

onready var ofcLst = $ColorRect/VBoxContainer/HBoxContainer/ItemList

signal select(dat)

func Set(ofc_list):
	data = ofc_list
	refresh()

func refresh():
	ofcLst.clear()
	for o in data:
		ofcLst.add_item(ofcLab(o))
	if len(data)>0:
		_on_ItemList_item_selected(0)

func ofcLab(ofcDat):
	var txt = "%s"%ofcDat.name
	if ofcDat.has("ship"):
		txt += "[*]"
	if ofcDat.has("fclt"):
		txt += "[#]"
	return txt

func SetMenuVisiable(val):
	$ColorRect/VBoxContainer/menu.visible = val

func _on_ItemList_item_selected(index):
	currentIndex = index
	$ColorRect/VBoxContainer/HBoxContainer/OfcInfoRT.Set(data[index])

func _on_Close_pressed():
	emit_signal("select",null)
	GlbUi.Pop()

func _on_OK_pressed():
	emit_signal("select",data[currentIndex])
	GlbUi.Pop()

func _on_ItemList_item_activated(index):
	emit_signal("select",data[index])
	GlbUi.Pop()

func _on_OfcInfoRT_value_change(ofc):
	refresh()
