extends Control

var data

func Set(card_list):
	data = card_list
	$List.clear()
	for card in data:
		$List.add_item(card.name)

func _on_OK_pressed():
	queue_free()

func _on_List_item_selected(index):
	$Info.Set(data[index])
