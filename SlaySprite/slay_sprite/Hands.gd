extends Control

func _ready():
	DrawAnim(Vector2(0,0),Vector2.ONE*500)

func DrawAnim(from,to):
	$Tween.interpolate_property($Card,"rect_position",from,to,1,Tween.TRANS_BACK,Tween.EASE_IN)
	$Tween.start()
