extends Node

func run(src,card,dst,para):
	for i in para.get("times",1):
		var enm = dst.get_parent().RndSel()
		src.DuelDamage(para,enm)
