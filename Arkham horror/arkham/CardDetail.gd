extends Node

func Show(dat):
	$img.texture = GlbDb.CardImg(dat.img)
	$img.show()

func Hide():
	$img.hide()
