extends Control

var data

func Set(dat):
	data = dat
	refresh()

func refresh():
	$TextureRect.texture = GlbDb.CardImg(data.img)
