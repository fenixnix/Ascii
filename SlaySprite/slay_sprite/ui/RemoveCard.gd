extends Control

var data
var cur_index = 0

signal finish()

func Set(deck):
	data = deck
	for card in data:
		$Deck.add_item(card.name)
	_on_Deck_item_selected(cur_index)

func _on_Deck_item_selected(index):
	cur_index = index
	$Card.Set(data[index])

func _on_OK_pressed():
	data.remove(cur_index)
	queue_free()
