extends Node

func run(src,card,dst,para):
	for c in src.hand:
		GlbAct.UpgradeCard(c)
