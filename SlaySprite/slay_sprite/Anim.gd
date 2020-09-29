extends Sprite

func shake(val):
	offset = Vector2(rand_range(-1,1),rand_range(-1,1))*val*16
