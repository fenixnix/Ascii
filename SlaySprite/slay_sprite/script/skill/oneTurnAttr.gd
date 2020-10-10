extends Node

func run(src,card,dst,para):
	src.ModStatus(para)
	src.add_child(self)
	src.connect("end_turn",self,"on_end_turn",[src,para])

func on_end_turn(src,para):
	src.ModStatus({
		"type":para.type,
		"val":-para.val
	})
	queue_free()
