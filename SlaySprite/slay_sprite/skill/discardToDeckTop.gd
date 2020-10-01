extends Node

func run(src,card,dst,para):
	GlbUi.SelectCard(src.discard)
	var c = yield(GlbUi,"select_card")
	src.deck.push_front(c)
