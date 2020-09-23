extends Control

var data

signal select(chara)

func Set(dat):
	data = dat
	$Name.text = dat.name
	$TextureRect.texture = GlbDb.CardImg(dat.img)
	$CharaRT.Set(dat)

func _on_TextureRect_gui_input(event:InputEvent):
	if event.is_action_pressed("click"):
		emit_signal("select",data)
