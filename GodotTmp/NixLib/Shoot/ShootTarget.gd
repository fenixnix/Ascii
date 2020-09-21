extends Node2D

class_name ShootTarget

export(PackedScene) var projectile
export(Array,NodePath) var fires = []
export(Array,NodePath) var objNodes = []

var objs = []
export var coolDown = .3

var cd = 0

func _ready():
	objs.clear()
	for n in objNodes:
		objs.append(get_node(n))

func Shoot(target):
	if cd>0:
		return
	if is_instance_valid(target):
		look_at(target.position)
		for c in fires:
			shoot(target,projectile,get_node(c))
		cd = coolDown

func shoot(target,projectile,transform):
	var b = projectile.instance()
	b.team = get_parent().team
	$"/root".add_child(b)
	b.Init(target, transform.global_position, transform.global_rotation)

func ShootTarget(target):
	if cd>0:
		return
	Shoot(target)
	cd = coolDown

func _process(delta):
	for o in objs:
		o.scale = Vector2.ONE
	if cd>0:
		cd -= delta
		for o in objs:
			o.scale = Vector2.ONE*(coolDown-cd)/coolDown
