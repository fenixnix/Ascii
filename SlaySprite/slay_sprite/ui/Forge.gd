extends Control

var data
var curCard

signal finish()

func Set(deck):
	data = deck
	$Deck.clear()
	for card in data:
		$Deck.add_item(card.name)
	if len(data)>0:
		_on_Deck_item_selected(0)

func _on_OK_pressed():
	emit_signal("finish")
	GlbAct.UpgradeCard(curCard)
	queue_free()

func _on_Deck_item_selected(index):
	curCard = data[index]
	$Src.Set(curCard)
	var tmpUpgradeCard = curCard.duplicate(true)
	tmpUpgradeCard = GlbAct.UpgradeCard(tmpUpgradeCard)
	$Dst.Set(tmpUpgradeCard)
