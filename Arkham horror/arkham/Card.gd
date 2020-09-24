extends Control

var data

signal use(card)

func Set(id):
	data = GlbDb.cardDict[id]
	refresh()

func refresh():
	$TextureRect.texture = GlbDb.CardImg(data.img)

func _on_TextureRect_mouse_entered():
	$TextureRect.rect_scale = Vector2.ONE*2
	$TextureRect.rect_position = Vector2(-70,-300)

func _on_TextureRect_mouse_exited():
	$TextureRect.rect_scale = Vector2.ONE
	$TextureRect.rect_position = Vector2.ZERO

func _on_TextureRect_gui_input(event:InputEvent):
	if event.is_action_pressed("click"):
		emit_signal("use",data)
