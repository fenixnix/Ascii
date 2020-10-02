extends Node

func run(src,card,dst,para):
	GlbUi.SelectCard(src.hand)
	var c = yield(GlbUi,"select_card")
	src.Exhaust(c)
