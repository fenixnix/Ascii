extends Node

func run(src:CharaBtl,card,dst,para):
	var cnt = 0
	for c in src.hand:
		src.Exhaust(c)
		cnt += 1
	var dmg = para.get("bonus",5)
	src.DuelDamage({"val":dmg,"times":cnt,"target":"all"})
