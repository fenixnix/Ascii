extends Control

var lst = []

func Reward(type,cnt=3):
	if type == "boss":
		lst = GlbDb.RandBossCardByClass(GlbDat.chara.class_)
	else:
		lst = GlbDb.RandomGainCardByClass(GlbDat.chara.class_,cnt)
	$ItemList.clear()
	for card in lst:
		$ItemList.add_item(card.name)
	_on_ItemList_item_selected(0)

func _on_OK_pressed():
	for card in $ItemList.get_selected_items():
		GlbDat.chara.cards.append(lst[card])
	queue_free()

func _on_Cancel_pressed():
	queue_free()

func _on_ItemList_item_selected(index):
	$Card.Set(lst[index])
