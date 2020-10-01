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
