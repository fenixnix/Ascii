extends Projectile

export(PackedScene) var blastPrefab
export var velocity = 64*2.5
export var lifeTime = 1.5
export var explosive_radius = 1.5

var target

func Init(_target,_position,_rotation):
	position = _position
	rotation = _rotation
	target = _target

func _physics_process(delta):
	if is_instance_valid(target):
		look_at(target.position)
		position += (target.position - position).normalized()*velocity*delta
	progress += delta
	if progress>lifeTime:
		Explore()
	
func Explore():
	$Effect2DGenerator.Play()
	queue_free()

func _on_projectile_body_entered(body):
	AffixDamage(body)

func _on_projectile_area_entered(area):
	AffixDamage(area)

func AffixDamage(target):
	var t = target.get("team")
	if t!=null && t == team:
		if target.team == team:
			return
	for c in target.get_children():
		if c is UnitLife:
			c.TakeDamage(damage)
	Explore()
