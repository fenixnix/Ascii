extends Node

class_name Ctrl8WayMove

export (int) var speed = 200

var velocity = Vector2()

onready var target:KinematicBody2D = get_parent()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	target.look_at(target.position + velocity)
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = target.move_and_slide(velocity)
