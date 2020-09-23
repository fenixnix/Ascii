extends Control

func Set(dat):
	$VBoxContainer/Name.text = dat.name
	$VBoxContainer/HBoxContainer/TextureRect.texture.atlas = GlbDb.CardImg(dat.img)
	$VBoxContainer/HBoxContainer/CharaRT.Set(dat)
