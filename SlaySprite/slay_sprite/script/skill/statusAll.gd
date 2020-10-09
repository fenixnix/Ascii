extends Node

func run(src,card,dst,para):
	for e in dst.get_parent().get_children():
		e.ModStatus(para)
