extends Node

var card_

func run(src:CharaBtl,card,dst,para):
	card_ = card
	src.connect("hurt",self,"on_hurt")

func on_hurt():
	card_.cost -= 1
	if card_.cost<0:
		card_.cost = 0
