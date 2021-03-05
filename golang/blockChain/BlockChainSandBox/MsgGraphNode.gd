extends GraphNode

func Anim(start,end,time):
	#print(start,end,time)
	$Tween.interpolate_property(self,"offset",start,end,time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	queue_free()