extends AnimatedSprite

func _ready():
	play("default")
	yield(self,"animation_finished")
	queue_free()
