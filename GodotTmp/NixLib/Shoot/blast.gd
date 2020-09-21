extends AnimatedSprite

func _ready():
	rotation =  rand_range(0,180)
	yield(get_tree().create_timer(0.3),"timeout")
	queue_free()
