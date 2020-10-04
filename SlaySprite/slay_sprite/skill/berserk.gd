extends Node

func run(src:CharaBtl,card,dst,para):
	src.add_child(self)
	src.ModStatus(para)
	src.connect("new_turn",self,"on_start_turn",[src])

func on_start_turn(src):
	src.en += 1
