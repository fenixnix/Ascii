extends Control

func _ready():
	Set(RndSel())

func Set(dat):
	$Icon.texture = load("res://image/relic/%s.png"%dat.img)

func RndSel():
	return {"img":"ancientCoin"}
