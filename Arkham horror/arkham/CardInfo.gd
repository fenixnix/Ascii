extends Control

func Set(dat):
	$TextureRect.texture = GlbDb.CardImg(dat.img)
