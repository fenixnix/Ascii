extends Node

class_name CtrlPlatformMove

export var maxSpeed = 200
export var acc = 256
export var jumpForce = 500

var velocity = Vector2(0,0)
var jump_timer = 0

onready var target:KinematicBody2D = get_parent()

func Jump():
	velocity = Vector2(0,-300)

func _physics_process(delta):
	if target.is_on_floor():
		#$alien_pink.animation = 'idle_front'
		if Input.is_action_pressed('right'):
			velocity.x += acc*delta
			#$alien_pink.animation = 'walk'
		elif Input.is_action_pressed("left"):
			velocity.x -= acc*delta
			#$alien_pink.animation = 'walk'
		else:
			velocity.x = lerp(velocity.x, 0, 0.1)
		if Input.is_action_pressed("jump"):
			if jump_timer<=0:
				velocity.y = -jumpForce
				jump_timer = 0.5
	else:
		#$alien_pink.animation = 'jump'
		if Input.is_action_pressed('right'):
			velocity.x += acc*delta/2
		elif Input.is_action_pressed('left'):
			velocity.x -= acc*delta/2
	
	if velocity.x > maxSpeed:
		velocity.x = maxSpeed
	if velocity.x < -maxSpeed:
		velocity.x = -maxSpeed

	jump_timer-=delta
	velocity.y += 20
	velocity = target.move_and_slide(velocity, Vector2.UP)
