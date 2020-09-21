extends Node

export var ctrlDir = false
export var LMB = true
export var RMB = false

onready var target = get_parent()

func _physics_process(delta):
	if ctrlDir:
		target.look_at(target.get_global_mouse_position())
	if Input.is_action_pressed("attack") && LMB:
		target.Shoot()
	if Input.is_action_pressed("RMB") && RMB:
		target.Shoot()
