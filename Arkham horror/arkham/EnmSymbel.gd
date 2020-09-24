extends Node2D

func Set(enm):
	$img.texture = GlbDb.CardImg(enm.img)
	$hp.text = str(enm.get("hp",0))
