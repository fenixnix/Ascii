extends Node

var src_
var para_

func run(src,card,dst,para):
	src_ = src
	para_ = para
	src.ModStatus({"type":"str","val":para.val})
	src.add_child(self)
	src.connect("end_turn",self,"on_end_turn")

func on_end_turn():
	src_.ModStatus({
		"type":"str",
		"val":-para_.val
	})
	queue_free()
