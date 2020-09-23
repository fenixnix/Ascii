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
	$Menu.visible = data.has("clues")
	if data.has("clues"):
		$Menu/shroud.text = str(data.shroud)
		$Menu/clues.text = str(data.clues)
