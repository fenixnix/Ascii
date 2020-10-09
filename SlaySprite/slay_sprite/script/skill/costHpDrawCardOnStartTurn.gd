extends Node

func run(src:CharaBtl,card,dst,para):
	src.add_child(self)
	src.connect("new_turn",self,"on_new_turn",[src])

func on_new_turn(src):
	src.costHp(1)
	src.Draw()
