extends Tween

func Shake(val):
	interpolate_method(self,"shake",val,.5,.5)
	start()

func shake(val):
	get_parent().offset = Vector2(rand_range(-1,1),rand_range(-1,1))*val
