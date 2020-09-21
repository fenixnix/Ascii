extends Spatial

export var target = Vector3(0,0,0)

func Play(_target):
	target = _target.translation
	yield(get_tree().create_timer(1.5),"timeout")
	queue_free()

func _process(delta):
	var dif = target - translation
	var l = dif.length()
	look_at(target,Vector3.UP)
	var mtrl:ParticlesMaterial = $Particles.process_material
	$Particles.lifetime = l/mtrl.initial_velocity
	$hit.translation = Vector3(0,0,-l)

func finish():
	yield(get_tree().create_timer(1),"timeout")
	queue_free()
