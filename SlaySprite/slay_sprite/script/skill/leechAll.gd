extends Node

func run(src:CharaBtl,card,dst,para):
	src.chara.hp += src.DuelDamage(para,e)
	for e in dst.get_parent().get_children():
