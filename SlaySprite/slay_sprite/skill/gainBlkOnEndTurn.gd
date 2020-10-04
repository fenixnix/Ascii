extends Node

var para_
var src_

func run(src:CharaBtl,card,dst,para):
	src_ = src
	para_ = para
	src.add_child(self)
	src.connect("end_turn",self,"on_end_turn")

func on_end_turn():
	src_.GainBlock(para_.blk)
