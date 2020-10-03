extends Node

func run(src:CharaBtl,card,dst,para):
	for e in dst.get_parent().get_children():
		src.chara.hp += src.DuelDamage(para,e)
