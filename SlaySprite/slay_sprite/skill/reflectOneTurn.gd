extends Node

var para_
func run(src:CharaBtl,card,dst,para):
	para_ = para
	src.add_child(self)
	src.connect("take_dmg",self,"on_take_dmg")
	src.connect("end_turn",self,"on_end_turn")

func on_take_dmg(atker,dmg):
	atker.TakeDamage(para_.dmg)

func on_end_turn():
	queue_free()
