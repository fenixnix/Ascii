extends Control

var data

func Set(dat):
	data = dat
	if len(data)>0:
		_on_ItemList_item_selected(0)
	refresh()
	
func refresh():
	$ItemList.clear()
	for o in data:
		$ItemList.add_item("%s @ %s"%[o.ofc.name,o.site.site_name])

func _on_ItemList_item_selected(index):
	$PanelContainer/OfficerInfoRT.Set(data[index].ofc)


func _on_Button_pressed():
	GlbUi.Pop()
