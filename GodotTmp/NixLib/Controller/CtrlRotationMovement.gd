extends Node

class_name CtrlRotationMovement

export (int) var speed = 200
export (float) var rotation_speed = 1.5

var velocity = Vector2()
var rotation_dir = 0

onready var target:KinematicBody2D = get_parent()

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		rotation_dir += 1
	if Input.is_action_pressed('left'):
		rotation_dir -= 1
	if Input.is_action_pressed('down'):
		velocity = Vector2(-speed, 0).rotated(target.rotation)
	if Input.is_action_pressed('up'):
		velocity = Vector2(speed, 0).rotated(target.rotation)

func _physics_process(delta):
	get_input()
	target.rotation += rotation_dir * rotation_speed * delta
	velocity = target.move_and_slide(velocity)
