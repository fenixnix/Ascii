extends Node

func run(src:CharaBtl,card,dst,para):
	src.add_child(self)
	src.connect("draw_card",self,"on_exhaust",[src])

func on_exhaust(card,src):
	src.Draw()
