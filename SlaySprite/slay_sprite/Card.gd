extends Control

var data

func Set(card):
	data = card
	$TextureRect.texture = GlbDb.CardImage(card.img)

func AnimMove(goal):
	$Tween.interpolate_property(self,"rect_position",rect_position,goal,
	0.5,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()

func _on_Card_mouse_entered():
	rect_scale = Vector2.ONE

func _on_Card_mouse_exited():
	rect_scale = Vector2.ONE*0.5
