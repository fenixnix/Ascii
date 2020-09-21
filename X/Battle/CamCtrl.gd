extends Camera

func _process(delta):
	var delta_mov = Vector3(0,0,0)
	if Input.is_key_pressed(KEY_E):
		delta_mov.z -= 1
	if Input.is_key_pressed(KEY_D):
		delta_mov.z += 1
	if Input.is_key_pressed(KEY_S):
		delta_mov.x -= 1
	if Input.is_key_pressed(KEY_F):
		delta_mov.x += 1
	translate(delta_mov*delta)
	
