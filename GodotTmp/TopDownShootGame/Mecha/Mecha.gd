extends KinematicBody2D

class_name Mecha

export var team = 0

signal dead()

onready var prevLocation = position
onready var anim = get_node_or_null("AnimationPlayer")

func _on_UnitLife_dead():
	emit_signal("dead")
	queue_free()

func _physics_process(delta):
	if anim!=null:
		if !position.is_equal_approx(prevLocation):
			prevLocation = position
			anim.play("MechaMoving")
		else:
			anim.stop(true)
