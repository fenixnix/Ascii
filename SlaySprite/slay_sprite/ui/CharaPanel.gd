extends Node

func Set(btl):
	$EN/Label.text = "%d/%d"%[btl.en,btl.chara.en]
	$Shield/Label.text = "%d"%[btl.blk]
	$HP.Set(btl.chara.hp,btl.chara.mhp)
	$Info.Set(btl)
