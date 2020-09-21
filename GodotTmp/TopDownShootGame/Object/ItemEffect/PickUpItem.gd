extends Area2D

export var animTime = 1
export(Script) var pickScript
var progress = 0
var target = null

func _on_Crate_body_entered(body):
	target = body

func _physics_process(delta):
	if target == null:
		return
	var weight = progress/animTime
	position = lerp(position,target.position,weight)
	scale = Vector2.ONE*(1-weight)
	progress += delta
	if progress>animTime:
		if pickScript != null:
			pickScript.PickUp(target)
		queue_free()
