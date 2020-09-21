extends Control

onready var build_list = $VBoxContainer2/ItemList

var data
var currentIndex = 0

signal select(data)

func Set(fclt_lst):
	data = fclt_lst
	build_list.clear()
	for fclt in data:
		build_list.add_item(fclt.name)
		if !GlbDat.currentSite.CheckBuildValid(fclt):
			build_list.set_item_custom_fg_color(build_list.get_item_count()-1,Color.red)
	$VBoxContainer2/Power.bbcode_text = "[img=16]%s[/img] %d/%d"%[GlbDb.icon_dict["power"],GlbDat.currentSite.PowerCost(),GlbDat.currentSite.PowerGen()]
	if len(fclt_lst)>0:
		_on_ItemList_item_selected(0)

func _on_Button_pressed():
	emit_signal("select",data[currentIndex])

func _on_ItemList_item_selected(index):
	currentIndex = index
	$VBoxContainer2/Menu/OK.disabled = !GlbDat.currentSite.CheckBuildValid(data[index])
	$Control/Info.Set(data[index])
