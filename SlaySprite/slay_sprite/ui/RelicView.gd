extends Control

var data

func Set(list):
	data = list
	$ItemList.clear()
	for relic in data:
		$ItemList.add_item(relic.name)
	_on_ItemList_item_selected(0)

func _on_ItemList_item_selected(index):
	$Relic.Set(data[index])
	$RelicRT.Set(data[index])
