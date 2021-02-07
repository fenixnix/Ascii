extends Control

func Set(txt,time = 1.5):
	$ColorRect/Label.text = txt
	yield(get_tree().create_timer(time),"timeout")
	$Tween.interpolate_property(self,'modulate',Color.white,Color(1,1,1,0),time)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	queue_free()
