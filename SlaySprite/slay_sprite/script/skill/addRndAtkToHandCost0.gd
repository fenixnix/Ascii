extends Node

func run(src:CharaBtl,card,dst,para):
	src.add_child(self)
	var c = GlbAct.RndGenAtkCard()
	var pre_cost = c.cost
	c.cost = 0
	src.InvokeCard(c)
	src.connect("end_turn",self,"on_end_turn",[c,pre_cost])

func on_end_turn(card,cost):
	card.cost = cost
