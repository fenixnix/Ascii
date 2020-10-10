extends Node

func init(src:CharaBtl,card,dst,para):
	src.add_child(self)
	src.connect("hurt",self,"on_hurt",[card])

func on_hurt(card):
	card.cost -= 1
	if card.cost<0:
		card.cost = 0
