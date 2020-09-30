extends Control

var lst = []

func Reward(type="red",lv=0,cnt=3):
	lst.clear()
	for c in cnt:
		lst.append(rand(type,lv))
	$ItemList.clear()
	for card in lst:
		$ItemList.add_item(card.name)

func rand(type,lv):
	match type:
		"red":
			return GlbDb.RandomSelect()
		_:pass

func _on_OK_pressed():
	for card in $ItemList.get_selected_items():
		GlbDat.chara.cards.append(lst[card])
	queue_free()

func _on_Cancel_pressed():
	queue_free()
