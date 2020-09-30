extends Sprite

func Shake():
	$Tween.interpolate_method(self,"shake",.1,.5,.5)
	$Tween.start()

func shake(val):
	offset = Vector2(rand_range(-1,1),rand_range(-1,1))*val*16

func Charge():
	var time = .1
	$Tween.interpolate_property(self,"scale",Vector2.ONE,Vector2.ONE*3,time)
	$Tween.interpolate_property(self,"modulate",Color.white,Color(1,1,1,.3),time)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	scale = Vector2.ONE
	modulate = Color.white
