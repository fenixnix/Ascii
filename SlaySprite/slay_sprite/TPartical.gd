extends Label

func _ready():
	$Tween.interpolate_property(self,"rect_position",rect_position,rect_position+Vector2.DOWN*-128,1.5)
	$Tween.interpolate_property(self,"modulate",Color.white,Color(1,1,1,0),1.5)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	queue_free()

