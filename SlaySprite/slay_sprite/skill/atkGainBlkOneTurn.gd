extends Node

func run(src:CharaBtl,card,dst,para):
	src.add_child(self)
	src.connect("play",self,"on_play_card",[src,para])
	src.connect("end_turn",self,"on_end_turn")

func on_play_card(card,src,para):
	if card.type == "Attack":
		src.GainBlock(para.blk)

func on_end_turn():
	queue_free()
