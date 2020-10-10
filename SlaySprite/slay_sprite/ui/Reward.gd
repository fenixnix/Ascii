extends Control

signal finish()

var data = []

func Set(dat):
	data.clear()
	match dat.type:
		"enm":
			AppendGold(ceil(rand_range(11,21)))
			data.append({"type":"card","val":"normal"})
			AppendPotion()
		"elite":
			AppendGold(ceil(rand_range(28,35)))
			data.append({"type":"card","val":"normal"})
			AppendPotion()
			AppendRelic(GlbDat.RollEliteRelic())
		"boss":
			AppendGold(ceil(rand_range(95,100)))
			data.append({"type":"card","val":"boss"})
			AppendPotion()
			data.append({"type":"boss_relic"})
		"chest":
			if dat.para.has("gold"):
				AppendGold(dat.para.gold)
			AppendRelic(dat.para.relic)
	refresh()

func AppendGold(amount):
	data.append({"type":"gold","val":amount})

func AppendPotion():
	var rarity = GlbDat.RollPotionRarity()
	if rarity!=null:
		var potion = GlbDb.RandomPotionByRarity(rarity)
		print_debug(potion)

func AppendRelic(relic):
	data.append({"type":"relic","val":relic})

func _on_Button_pressed():
	emit_signal("finish")
	queue_free()

func refresh():
	$ItemList.clear()
	for d in data:
		print(d)
		match d.type:
			"gold":$ItemList.add_item(str(d.val))
			"card":
				if d.val == "boss":
					$ItemList.add_item("Boss Card")
				else:
					$ItemList.add_item("Card")
			"relic":
				$ItemList.add_item(d.val.name)
			"boss_relic":
				$ItemList.add_item("Boss Relic")
