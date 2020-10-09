extends Node

func run(src:CharaBtl,card,dst,para):
	src.add_child(self)
	src.connect("new_turn",self,"on",[src,para])

func on(hp,src,para):
	src.ModAttr(para)
