extends Node

func run(btl:Enemy,para):
	btl.add_child(self)
	btl.connect("end_turn",self,"on_end_turn",[btl,para])

func on_end_turn(btl,para):
	GlbAct.modDict(para,btl.attr)
