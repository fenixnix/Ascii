extends Node

class_name MovementAgent

export (int) var grid_size = 64
export var speed = 3.0

var velocity = Vector2()
var targetPoint = Vector2()
var approchDistance = 8
var moving = false

onready var target:KinematicBody2D = get_parent()

func MoveTo(point):
	targetPoint = point
	target.look_at(targetPoint)
	approchDistance = 8
	moving = true

func Approch(target,distanceInPixel = 8):
	MoveTo(target.position)
	approchDistance = distanceInPixel

func MovePath(path):
	pass

func _physics_process(delta):
	if !moving:
		return
	velocity = (targetPoint - target.position).normalized()*speed*grid_size
	velocity = target.move_and_slide(velocity)
	if (targetPoint - target.position).length() < approchDistance:
		moving = false
