extends HBoxContainer

var data

func Set(ect):
	data = ect
	$act/OptionButton.clear()
	for act in data.act:
		$act/OptionButton.add_item(act.name)
	$agenda/OptionButton2.clear()
	for agenda in data.agenda:
		$agenda/OptionButton2.add_item(agenda.name)
	_on_OptionButton_item_selected(0)
	_on_OptionButton2_item_selected(0)

func _on_OptionButton_item_selected(index):
	$act/TextureRect.texture = GlbDb.CardImg(data.act[index].img)

func _on_OptionButton2_item_selected(index):
	$agenda/TextureRect2.texture = GlbDb.CardImg(data.agenda[index].img)

func _on_OptionButton2_item_focused(index):
	$agenda/TextureRect2.texture = GlbDb.CardImg(data.agenda[index].img)

func _on_OptionButton_item_focused(index):
	$act/TextureRect.texture = GlbDb.CardImg(data.act[index].img)
