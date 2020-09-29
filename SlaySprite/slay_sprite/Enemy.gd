extends Node2D

var mhp = 20
var hp = 15
var blk = 0

var skills = []
var attr = {}
var status = {}

signal select(target)

func _ready():
	refresh_info()

func refresh_info():
	$EnemyUI/Info.Set(self)

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
