extends PanelContainer

func _on_Deck_pressed():
	GlbUi.CardView()

func Refresh():
	var chara = GlbDat.chara
	$Menu/HP.text = "%d/%d"%[chara.hp,chara.mhp]
	$Menu/Gold.text = str(GlbDat.gold)
	$Menu/Floor.text = str(GlbDat.cur_floor)
	$Menu/PotionSlots.Set(chara.potionSlots)
