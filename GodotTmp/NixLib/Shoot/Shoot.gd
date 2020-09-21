extends Node2D

export(PackedScene) var projectile
export(Array,NodePath) var fires = []
export(Array,NodePath) var objs = []
export var coolDown = .3

var cd = 0

func Shoot():
	if cd>0:
		return
	for c in fires:
		shoot(projectile,get_node(c))
	cd = coolDown

func shoot(projectile,transform):
	var sfx = get_node_or_null("SFX")
	if sfx!=null:
		sfx.play()
	var b = projectile.instance()
	$"/root".add_child(b)
	b.Init(null,transform.global_position,transform.global_rotation)

func _physics_process(delta):
	if cd>0:
		cd -= delta
	for o in objs:
		o.visible = cd<0
