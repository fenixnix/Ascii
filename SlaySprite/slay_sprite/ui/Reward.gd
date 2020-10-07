extends Control

signal finish()

func _ready():
	#gold
	GlbDat.gold += 20+floor(rand_range(-5,5))
	#card
	GlbUi.CardReward()
	#potion
	var rarity = GlbDat.RollPotion()
	if rarity!=null:
		var potion = GlbDb.RandomPotion(rarity)
		print_debug(potion)
	#ralic
	#TODO

func _on_Button_pressed():
	emit_signal("finish")
	queue_free()
