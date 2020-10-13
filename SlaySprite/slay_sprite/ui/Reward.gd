extends Control

signal finish()

var data = []

func Set(dat):
	data.clear()
	match dat.type:
		"enm":
			AppendGold(ceil(rand_range(10,20)))
			data.append({"type":"card","val":"normal"})
			AppendPotion()
		"elite":
			AppendGold(ceil(rand_range(25,35)))
			data.append({"type":"card","val":"normal"})
			AppendPotion()
			AppendRelic(GlbDb.RandRelicByClass(GlbDat.chara.class_))
		"boss":
			AppendGold(ceil(rand_range(95,105)))
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
		data.append({"type":"potion","val":potion})

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
			"gold":$ItemList.add_item(str(d.val),GlbDb.GetIcon("gold"))
			"card":
				if d.val == "boss":
					$ItemList.add_item("Boss Card",GlbDb.GetIcon("bossCardReward"))
				else:
					$ItemList.add_item("Card",GlbDb.GetIcon("normalCardReward"))
			"potion":
				$ItemList.add_item("Potion",GlbDb.GetIcon("brewmaster"))
			"relic":
				$ItemList.add_item(d.val.name,GlbDb.GetIcon("vintage"))
			"boss_relic":
				$ItemList.add_item("Boss Relic",GlbDb.GetIcon("chest"))

func _on_ItemList_item_activated(index):
	var rwd = data[index]
	data.remove(index)
	match rwd.type:
		"gold":
			GlbAct.GainGold(rwd.val)
		"card":
			GlbAct.RewardCard(rwd.val)
		"potion":
			GlbDat.chara.GainPotion(rwd.val)
		"relic":
			GlbDat.chara.GainRelic(rwd.val.id)
		"boss_relic":
			pass
	refresh()
