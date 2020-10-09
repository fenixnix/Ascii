extends Node

var src_
var para_
func run(src:CharaBtl,card,dst,para):
	src_ = src
	para_ = para
	src.add_child(self)
	src.connect("draw_card",self,"on_draw")

func on_draw(card):
	if card.type == "Status" || card.type == "Curse":
		for e in GlbAct.BattleGround().get_children():
			e.TakeDamage(para_.dmg)
