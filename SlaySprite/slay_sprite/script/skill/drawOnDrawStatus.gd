extends Node

func run(src:CharaBtl,card,dst,para):
	src.add_child(self)
	src.connect("draw_card",self,"on_draw",[src,para])

func on_draw(card,src,para):
	if card.type == "Status":
		for i in para.count:
			src.Draw()
