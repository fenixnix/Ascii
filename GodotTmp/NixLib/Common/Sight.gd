extends Area2D

class_name Sight

export (float) var SightRange = 3

var targets = []

onready var team = get_parent().team

func _ready():
	var col = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius =  SightRange * GlbTileSetting.GridSize
	col.shape = shape
	add_child(col)
	monitorable = false
	connect("body_entered",self,"_on_ViewRange2D_body_entered")
	connect("body_exited",self,"_on_ViewRange2D_body_exited")

func GetTargets():
	ClearInvalidTarget()
	return targets

func GetNearestTarget():
	ClearInvalidTarget()
	var minDistanceSqua = 4096*4096
	var nearestTarget = null
	for t in targets:
		var dif = t.position - position
		var lenSqua = dif.length_squared()
		if lenSqua < minDistanceSqua:
			minDistanceSqua = lenSqua
			nearestTarget = t
	return nearestTarget

func ClearInvalidTarget():
	for t in targets:
		if !is_instance_valid(t):
			targets.erase(t)

func _on_ViewRange2D_body_entered(body):
	var t = body.get("team")
	if t!=null && t == team:
		if body.team == team:
			return
	targets.append(body)

func _on_ViewRange2D_body_exited(body):
	targets.erase(body)
