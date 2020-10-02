extends Node

func GetChara():
	return get_tree().current_scene.get_node("battle").plrBtl

func PlayCard(card,target = null):
	GetChara().PlayCard(card,target)

func UpgradeCard(card):
	return card

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
