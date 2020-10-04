extends Node

var para_
var src_

func run(src:CharaBtl,card,dst,para):
	src_ = src
	para_ = para
	src.add_child(self)
	src.connect("exhaust",self,"on_exhaust")

func on_exhaust():
	src_.GainBlock(para_.blk)
