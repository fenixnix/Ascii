extends Node

func run(src,card,dst,para):
	var tmp = []
	for c in src.hand:
		if c!=card:
			tmp.append(c)
	GlbUi.SelectCard(tmp)
	var c = yield(GlbUi,"select_card")
	GlbAct.UpgradeCard(c)
