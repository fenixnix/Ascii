extends Spatial

var target
var shooting = false
var speed = 1.0

func Play(_target):
	target = _target
	$Particles.emitting = true
	yield(get_tree().create_timer(0.5),"timeout")
	$Trail.emitting = true
	shooting = true

func _process(delta):
	if shooting:
		var dif:Vector3 = target.translation - (get_parent().translation+translation)
		translation = lerp(translation,translation+dif.normalized()*speed,0.5)
		if dif.length_squared()<0.1:
			$Trail.emitting = false
			$Explosive.emitting = true
			shooting = false
			finish()

func finish():
	yield(get_tree().create_timer(1),"timeout")
	queue_free()
