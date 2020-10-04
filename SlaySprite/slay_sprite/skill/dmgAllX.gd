extends Node

func run(src,card,dst,para):
	var X = src.en + 0
	for i in X:
		for e in dst.get_parent().get_children():
			src.DuelDamage(para,e)
