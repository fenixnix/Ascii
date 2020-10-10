extends Node
#Desc:At the start of each combat, draw 2 additional cards.
func Pickup(chara):
	pass

func Init(chara):
	GlbAct.connect("battle_start",self,"on_battle_start",[chara])

func on_battle_start(chara):
	GlbAct.GetChara().Draw()
	GlbAct.GetChara().Draw()
