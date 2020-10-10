extends Node
#Desc:Gain 1 Energy at the start of each turn. On Card Reward screens, you have 2 fewer cards to choose from
func Pickup(chara):
	pass

func Init(chara):
	GlbAct.connect("battle_win",self,"on_battle_win",[chara])

func on_battle_win(chara):
	chara.Heal(6)
