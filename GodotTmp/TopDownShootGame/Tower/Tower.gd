extends StaticBody2D

class_name Tower

export var team = 0

var targets = []

func AimAt(target_position):
	$Shoot.look_at(target_position)

func Shoot():
	for t in targets:
		$Shoot.Shoot(t)
		return

func _physics_process(delta):
	for t in targets:
		if is_instance_valid(t):
			AimAt(t.position)
			return

func _on_UnitLife_dead():
	$Effect2D.Play()
	queue_free()

func _on_ViewRange2D_body_entered(body):
	var t = body.get("team")
	if t!=null && t == team:
		if body.team == team:
			return
	targets.append(body)

func _on_ViewRange2D_body_exited(body):
	targets.erase(body)
