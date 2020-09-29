extends Control

var data
var tmp_goal = Vector2.ZERO

onready var panel = $Control/CardPanel

func Set(card):
	data = card
	panel.Set(card)

func AnimMove(_goal):
	if (tmp_goal-_goal).length_squared()>1:
		tmp_goal = _goal
		$Tween.interpolate_property(self,"rect_position",rect_position,tmp_goal,
		0.5,Tween.TRANS_QUAD,Tween.EASE_IN)
		$Tween.start()

func _on_HotArea_mouse_entered():
	$Control.rect_scale = Vector2.ONE
	$Control.rect_position += Vector2.UP*100

func _on_HotArea_mouse_exited():
	$Control.rect_scale = Vector2.ONE*0.5
	$Control.rect_position -= Vector2.UP*100
