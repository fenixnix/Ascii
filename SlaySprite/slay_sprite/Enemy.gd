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

func Set(enm):
	mhp = enm.hp.val+randi()%int(enm.hp.rnd)
	hp = mhp
	skills = enm.skl.duplicate(true)
	refresh_info()

func _ready():
	refresh_info()

func refresh_info():
	$EnemyUI/Info.Set(self)

func Action():
	print("%s action"%enemy_name)

func TakeDamage(_dmg):
	var dmg = _dmg
	if status.has("vul"):
		dmg = ceil(dmg*1.5)
	var overDmg = clamp(dmg-blk,0,65535)
	blk = clamp(blk-dmg,0,65535)
	hp -= overDmg
	if hp<=0:
		hp = 0
	refresh_info()
#		on_dead()
#	emit_signal("hurt",attacker,dmg)

func AddStatus(d):
	if status.has(d.type):
		status[d.type] += d.val
	else:
		status[d.type] = d.val
	refresh_info()
