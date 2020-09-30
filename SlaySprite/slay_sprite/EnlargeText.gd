extends Control

func _ready():
	$Tween.interpolate_property(self,"rect_scale",rect_scale,Vector2.ONE*3,1)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	queue_free()

func Set(msg):
	$Label.text = msg
