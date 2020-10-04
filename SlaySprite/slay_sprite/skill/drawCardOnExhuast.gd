extends Node

var src_
func run(src:CharaBtl,card,dst,para):
	src_ = src
	src.add_child(self)
	src_.connect("draw_card",self,"on_exhaust")

func on_exhaust(_card):
	src_.Draw()
