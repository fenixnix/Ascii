extends Control

signal finish()

#gold enm 11~19 elite 28~34 boss 99 chest = elite

func _ready():
	#gold
	GlbDat.gold += 11+randi()%8
	#card
	GlbUi.CardReward()
	#potion
	var rarity = GlbDat.RollPotionRarity()
	if rarity!=null:
		var potion = GlbDb.RandomPotion(rarity)
		print_debug(potion)
	#ralic
	#TODO

func _on_Button_pressed():
	emit_signal("finish")
	queue_free()
