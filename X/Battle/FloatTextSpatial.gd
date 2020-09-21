extends Position2D

export var time = 1

var text setget set_text

func set_text(txt):
	$Label.text = txt
	var color = $Label.modulate
	var color_d = Color(color.r,color.g,color.b,0)
	$Tween.interpolate_property($Label,"rect_position",Vector2.ZERO,Vector2(0,-64),time,Tween.TRANS_BACK,Tween.EASE_IN)
	$Tween.interpolate_property($Label,"rect_scale",Vector2.ONE,Vector2.ONE*1.2,time,Tween.TRANS_BACK,Tween.EASE_OUT)
	$Tween.interpolate_property($Label,"modulate",color,color_d,time,Tween.TRANS_BACK,Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	queue_free()
