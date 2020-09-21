extends Control

signal select()

func Set(dat):
	$Label.text = dat.name
	$TextureProgress.value = dat.hp*100
