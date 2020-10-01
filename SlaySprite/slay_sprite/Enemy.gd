extends Node2D

class_name Enemy

var enemy_name = "enemy"
var img

var mhp = 20
var hp = 15
var blk = 0

var attr = {}
var status = {}

var skills = []

var data
var action_index = 0

func Set(enm):
	data = enm
	mhp = enm.hp.val+randi()%int(enm.hp.rnd)
	hp = mhp
	skills = enm.skl.duplicate(true)
	refresh_info()

func _ready():
	refresh_info()

func refresh_info():
	$EnemyUI/Info.Set(self)

func ShowAction():
	var skl = data.skl[action_index]
	match skl.type:
		"dmg":
			$EnemyUI/plan.text = "%s %d"%["Attack",sklDmg(skl)]

func Action():
	var skl = data.skl[action_index]
	print("%s action use %s"%[enemy_name,str(skl)])
	match skl.type:
		"dmg":Attack(skl)
	action_index = posmod(action_index+1,len(data.skl_loop))

func Attack(dat):
	var dmg = sklDmg(dat)
	$Anim.Charge()
	GlbAct.GetChara().TakeDamage(self,dmg)

func sklDmg(skl):
	var dmg = skl.get("val",0)+attr.get("str",0)
	if status.has("weak"):
		dmg = ceil(dmg*.75)
	return dmg

func TakeDamage(_dmg):
	var dmg = _dmg
	if status.has("vul"):
		dmg = ceil(dmg*1.5)
	var overDmg = clamp(dmg-blk,0,65535)
	blk = clamp(blk-dmg,0,65535)
	hp -= overDmg
	
	#AnimEffect
	$TextPartical.Play(str(overDmg))
	$Anim.Shake()
	$Anim/Sprite.Shake()

	if hp<=0:
		hp = 0
		on_dead()
	refresh_info()

func on_dead():
	#Play Dead Anim
	if get_parent().EnemyAllDead():
		GlbAct.BattleWin()
	yield(get_tree().create_timer(1),"timeout")
	queue_free()

func ModStatus(d):
	if status.has(d.type):
		status[d.type] += d.val
	else:
		status[d.type] = d.val
	refresh_info()
