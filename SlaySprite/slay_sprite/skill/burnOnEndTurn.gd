extends Node

var battleGround
var src_
var para_

func run(src:CharaBtl,card,dst,para):
	src_ = src
	para_ = para
	battleGround = dst.get_parent()
	add_child(self)
	src.connect("end_turn",self,"on_end_turn")

func on_end_turn():
	src_.chara.hp -= 1
	for e in battleGround.get_children():
		e.TakeDamage(para_.get("dmg",5))
	
