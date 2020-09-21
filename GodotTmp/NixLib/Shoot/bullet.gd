extends Projectile

export var velocity = Vector2.RIGHT*256
export var lifeTime = 1.5
export var max_distance_travelled = 192

var distance_travelled = 0

func Init(_target, _position, _rotation):
	position = _position
	rotation = _rotation
	velocity = velocity.rotated(_rotation)
	
func _physics_process(delta):
	position += velocity * delta
	distance_travelled += velocity.length()*delta
	if distance_travelled>max_distance_travelled:
		queue_free()
	progress += delta
	if progress>lifeTime:
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
	Explosive()

func Explosive():
	queue_free()
	if has_node("Effect2DGenerator"):
		$Effect2DGenerator.Play()
