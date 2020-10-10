extends Control

func _ready():
	Set(RndSel())

func Set(dat):
	print(dat)
	var img = dat.name.to_lower().replace(' ','_')
	print(img)
	$Icon.texture = load("res://image/relic/%s.png"%img)
	$Icon.hint_tooltip = "%s\n\n\t%s"%[dat.name,dat.desc]

func RndSel():
	return GlbDb.relicDict.values()[randi()%len(GlbDb.relicDict.keys())]
