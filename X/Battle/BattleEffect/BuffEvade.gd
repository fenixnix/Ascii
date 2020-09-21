extends Spatial

func Play(_target):
	$Particles.emitting = true
	yield(get_tree().create_timer(3),"timeout")
	queue_free()
