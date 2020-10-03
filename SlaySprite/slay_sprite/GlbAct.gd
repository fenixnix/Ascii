extends Node

func GetChara():
	return get_tree().current_scene.get_node("battle").plrBtl

func PlayCard(card,target = null):
	GetChara().PlayCard(card,target)

func UpgradeCard(card):
	var dict = card.get("upgrade",{})
	if len(dict) == 0:
		return card
	card.name += "+"
	for k in dict.keys():
		match k:
			"dmg":
				for d in card.desc:
					if d.type == "dmg":
						d.val += dict[k]
			"blk":
				for d in card.desc:
					if d.type == "blk":
						d.val += dict[k]
			"cost":
				card.cost += dict[k]
			"replace_script":
				for d in card.desc:
					if d.type == "script":
						d.val = dict[k]
			"replace_script_para":
				for d in card.desc:
					if d.type == "script":
						print(dict[k])
						#TODO
	if !card.desc.has("InfUpgrade"):
		card.erase("upgrade")
	return card

func BattleGround():
	return get_tree().current_scene.get_node("battle")

func BattleWin():
	get_tree().current_scene.get_node("battle").Stop()
	print_debug("Battle Win!!!")
	GlbUi.CardReward()

static func modDict(dat,dict):
	if !dict.has(dat.type):
		dict[dat.type] = dat.val
	else:
		dict[dat.type] += dat.val
	if dict[dat.type] == 0:
		dict.erase(dat.type)
