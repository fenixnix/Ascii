extends Node2D

var data
var chara = []
var enm = []

func Set(dat):
	data = dat
	refresh()

func refresh():
	name = str(data.id)
	position = Vector2(data.X,data.Y)
	$Name.text = data.name
	$Sprite.texture = GlbDb.CardImg(data.img)
	
	var has_clues = data.has("clues")
	$shroud.visible = has_clues
	$clues.visible = has_clues
	if has_clues:
		$shroud.text = str(data.shroud)
		$clues.text = str(data.clues)
