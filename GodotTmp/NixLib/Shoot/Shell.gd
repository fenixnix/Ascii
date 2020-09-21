extends Projectile

export(PackedScene) var blastPrefab
export var velocity = Vector2.RIGHT*256
export var lifeTime = 1.5
export var explosive_radius = 1.5

var dstPoint = Vector2()
var srcPoint = Vector2()

func Init(_target, _position, _rotation):
	position = _position
	srcPoint = position
	rotation = _rotation
	dstPoint = _target.position

func _physics_process(delta):
	var prog = progress/lifeTime
	position = lerp(srcPoint,dstPoint,progress)
	scale = Vector2.ONE*(sin(prog*PI)+1)
	progress += delta
	if progress>lifeTime:
		Explore()
	
func Explore():
	$Effect2DGenerator.Play()
	queue_free()

#func _on_projectile_body_entered(body):
#	if body is Unit:
#		body.TakeDamage(damage)
#	queue_free()
#
#	var blast = blastPrefab.instance()
#	$"/root".add_child(blast)
#	blast.position = global_position

#func _on_projectile_area_entered(area):
#	if area is Tower:
#		area.TakeDamage(damage)
#	queue_free()
