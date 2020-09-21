extends Node2D

class_name Turrent

var targets = []

onready var team = get_parent().team

export var coolDown = .3
export(PackedScene) var ammo
export(Array,NodePath) var fires = []

#export(Array,NodePath) var objNodes = []
#var objs = []

var cd = 0

func SetTeam(t):
	team = t
	$Sight.team = t

func ShootNearestTarget():
	var target = $Sight.GetNearestTarget()
	if target!=null:
		Shoot(target)

func Shoot(target):
	if is_instance_valid(target):
		look_at(target.position)
		if cd >0 :
			return
		for c in fires:
			shoot(target,ammo,get_node(c))
		cd = coolDown

func AimAtNearestTarget():
	var target = $Sight.GetNearestTarget()
	if target!=null:
		look_at(target.position)

func shoot(target,projectile,transform):
	var b = projectile.instance()
	b.team = get_parent().team
	$"/root".add_child(b)
	b.Init(target, transform.global_position, transform.global_rotation)

func _process(delta):
	if cd>0:
		cd -= delta
