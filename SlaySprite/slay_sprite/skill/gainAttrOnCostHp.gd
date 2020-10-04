extends Node

func run(src:CharaBtl,card,dst,para):
	src.add_child(self)
	src.connect("cost_hp",self,"on_cost_hp",[src,para])

func on_cost_hp(hp,src,para):
	src.ModAttr(para)
