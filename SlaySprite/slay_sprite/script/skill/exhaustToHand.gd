extends Node

func run(src:CharaBtl,card,dst,para):
	GlbUi.SelectCard(src.exhaust)
	var c = yield(GlbUi,"select_card")
	src.exhaust.erase(c)
	src.Invoke(c)
