extends Node

func Set(btl):
	$EN/Label.text = "%d/%d"%[btl.en,btl.chara.en]
	$Shield/Label.text = "%d"%[btl.blk]
	$HP.value = btl.chara.hp*100/btl.chara.mhp
	$HP/Label.text = "%d/%d"%[btl.chara.hp,btl.chara.mhp]
	$Info.Set(btl)
