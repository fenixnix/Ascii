extends KinematicBody2D

class_name Unit

var velocity = Vector2(0,0)

func _ready():
	Init(
		{
			"Sprite":"res://Platform/Image/Unit/character_roundGreen.png",
			"hand":"res://Platform/Image/Unit/character_handGreen.png",
			"head":"res://Platform/Image/Unit/item_helmet.png",
		}
	)

func Init(data):
	$Sprite.texture = load(data.Sprite)
	$Sprite/Mainhand.texture = load(data.hand)
	$Sprite/Offhand.texture = load(data.hand)
	$Sprite/Head.texture = load(data.head)

func Attack():
	#$AnimationPlayer.play("Attack")
	#$Sprite/Offhand/item_sword/effect_trail.visible = true
	$Shoot.Shoot()

func Jump():
	if is_on_floor():
		velocity.y = -500

func Move(dir):
	velocity = dir

func LookAt(pos):
	if pos.x>position.x:
		$Sprite.scale = Vector2.ONE
	else:
		$Sprite.scale = Vector2(-1,1)
	$Sprite/Gun.look_at(pos)
	$Shoot.look_at(pos)

func TakeDamage(dmg):
	$Life.TakeDamage(dmg)
	
func Dead():
	$Collision.set_deferred("disabled",true)
	velocity = Vector2(0,-300)
	rotation = rand_range(-PI,PI)/6
	yield(get_tree().create_timer(3),"timeout")
	queue_free()
	
func _physics_process(delta):
	velocity.y += 20
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Life_dead():
	Dead()
