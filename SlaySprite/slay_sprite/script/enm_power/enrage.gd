extends Node

func init(val = 2):
	GlbAct.GetChara().connect("play",self,"on_play",[val])

func on_play(card,val):
	match card.type:
		"Skill","Power":
			get_parent().ModAttr({"type":"str","val":val})
