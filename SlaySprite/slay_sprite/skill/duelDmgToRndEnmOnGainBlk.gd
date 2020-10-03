extends Node

var para_

func run(src:CharaBtl,card,dst,para):
	para_ = para
	src.add_child(self)
	src.connect("gain_block",self,"on_gain_block")

func on_gain_block(_val):
	var enm = GlbAct.BattleGround().RndSel()
	enm.TakeDamage(para_.dmg)
