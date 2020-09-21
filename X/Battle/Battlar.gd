extends Spatial

var team = 0

var mhp = 100
var hp = 1
var spd = 1

var wpns = []

var moving = false
var mov_target = null

var aim_target = null

func Load(dat):
	wpns.clear()
	for wpn in dat.wpns:
		wpns.append(Weapon.InitWpnForBtl(wpn.slot))
	print(wpns)

func Aim(_target):
	aim_target = _target

func Enclose(_target):
	mov_target = _target
	moving = true

func _physics_process(delta):
	mov(delta)
	use_wpn(delta)

func mov(delta):
	if moving&&mov_target!=null:
		var dif:Vector3 = mov_target.translation-translation
		$Sprite3D.flip_h = dif.x<0
		translation+= dif.normalized()*spd*delta

func use_wpn(delta):
	if aim_target==null:
		return
	for w in wpns:
		if w.cd <=0:
			cast(w)
			w.cd = w.cd_cap
		else:
			w.cd -= delta

func cast(wpn):
	var prefab = load(wpn.get("anim","res://Battle/BattleEffect/ion.tscn"))
	var anim = prefab.instance()
	add_child(anim)
	anim.Play(aim_target)
