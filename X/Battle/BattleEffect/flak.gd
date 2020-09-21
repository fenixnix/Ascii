extends Spatial

var target

func Play(_target):
	target = _target
	var dif:Vector3 = target.translation - (get_parent().translation+translation)
	$Particles.lifetime = dif.length()/10.0
	look_at(target.translation,Vector3.UP)
	$Particles.emitting = true
	yield(get_tree().create_timer(3.0),"timeout")
	queue_free()

