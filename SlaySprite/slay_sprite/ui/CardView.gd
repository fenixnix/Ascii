extends Control

var data
var currentCard

func Set(card_list):
	data = card_list
	$List.clear()
	for card in data:
		$List.add_item(card.name)
	if len(card_list)>0:
		_on_List_item_selected(0)

func _on_OK_pressed():
	queue_free()

func _on_List_item_selected(index):
	currentCard = data[index]
	refresh()

func refresh():
	$Info.Set(currentCard)
	$Card.Set(currentCard)

func _on_TestUpgrade_pressed():
	currentCard = GlbAct.UpgradeCard(currentCard)
	refresh()
