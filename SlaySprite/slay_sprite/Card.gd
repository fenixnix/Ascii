extends Control

var data

onready var panel = $Control/CardPanel

func Set(card):
	data = card
	panel.Set(card)

func AnimMove(goal):
	$Tween.interpolate_property(self,"rect_position",rect_position,goal,
	0.5,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()

func _on_HotArea_mouse_entered():
	$Control.rect_scale = Vector2.ONE
	$Control.rect_position += Vector2.UP*100
	show_behind_parent = true

func _on_HotArea_mouse_exited():
	$Control.rect_scale = Vector2.ONE*0.5
	$Control.rect_position -= Vector2.UP*100
	show_behind_parent = false
