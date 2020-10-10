extends Control

onready var relic_prefab = preload("res://Relic.tscn")

func _on_Deck_pressed():
	GlbUi.CardView()

func Refresh():
	var chara = GlbDat.chara
	$Menu/HP.text = "%d/%d"%[chara.hp,chara.mhp]
	$Menu/Gold.text = str(GlbDat.gold)
	$Menu/Floor.text = str(GlbDat.cur_floor)
	$Menu/PotionSlots.Set(chara.potionSlots)
	Clear()
	for r in chara.relic:
		var rlc = relic_prefab.instance()
		$RelicList.add_child(rlc)
		rlc.Set(GlbDb.relicDict[r])

func Clear():
	for c in $RelicList.get_children():
		c.queue_free()
	yield(get_tree(),"idle_frame")
