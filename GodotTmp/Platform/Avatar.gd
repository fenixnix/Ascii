extends KinematicBody2D

class_name Avatar

func _ready():
	Init(
		{
			"body":"res://Platform/Image/Unit/character_roundGreen.png",
			"hand":"res://Platform/Image/Unit/character_handGreen.png",
			"head":"res://Platform/Image/Unit/item_helmet.png",
		}
	)
	
func RefreshHUD():
	for c in $HUD/LifeBar.get_children():
		c.queue_free()
	for i in $Life.life:
		var lifePoint = TextureRect.new()
		lifePoint.texture = load("res://Platform/Image/Tile/tile_heart.png")
		$HUD/LifeBar.add_child(lifePoint)

func Init(data):
	$Body.texture = load(data.body)
	$Body/Mainhand.texture = load(data.hand)
	$Body/Offhand.texture = load(data.hand)
	$Body/Head.texture = load(data.head)
	RefreshHUD()

func Attack():
	#$AnimationPlayer.play("Attack")
	#$Body/Offhand/item_sword/effect_trail.visible = true
	$Shoot.Shoot()

func TakeDamage(dmg):
	$Life.TakeDamage(dmg)
	RefreshHUD()

func Dead():
	$Collision.set_deferred("disabled",true)
	$CtrlPlatformMovement.Jump()
	rotation = rand_range(-PI,PI)/6
	yield(get_tree().create_timer(3),"timeout")
	queue_free()

func _physics_process(delta):
	$Shoot.look_at(get_global_mouse_position())
	$Body/Gun.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("attack"):
		Attack()
	if position.x<get_global_mouse_position().x:
		$Body.scale = Vector2.ONE
	else:
		$Body.scale = Vector2(-1,1)

func _on_Life_dead():
	Dead()
