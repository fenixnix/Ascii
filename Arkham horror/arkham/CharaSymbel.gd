extends Node2D

func Set(dat):
	$img.texture = GlbDb.CardImg(dat.data.img)
