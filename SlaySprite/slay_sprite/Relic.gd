extends Control

func _ready():
	Set(RndSel())

func Set(dat):
	print(dat)
	var img = dat.name.to_lower().replace(' ','_')
	print(img)
	$Icon.texture = load("res://image/relic/%s.png"%img)

func RndSel():
	return GlbDb.relicDict.values()[randi()%len(GlbDb.relicDict.keys())]
