extends Control

var data
var chara

signal select(chara)

func Set(dat):
	chara = dat
	data = dat.data
	$Name.text = data.name
	$TextureRect.texture = GlbDb.CardImg(data.img)
	$CharaRT.Set(chara)

func _on_CharaLabel_gui_input(event):
	if event.is_action_pressed("click"):
		emit_signal("select",chara)
