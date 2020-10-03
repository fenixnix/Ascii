extends Node

func run(src:CharaBtl,card,dst,para):
	var cnt = 0
	for c in src.hand:
		src.Exhaust(c)
		cnt += 1
	var dmg = para.get("bonus",5)*cnt
	for e in GlbAct.BattleGround().get_children():
		src.DuelDamage({"val":dmg},e)
