extends Node2D

class_name Enemy

var enemy_name = "enemy"
var img

var mhp:int = 20
var hp:int = 15
var blk:int = 0

var attr = {}
var status = {}
var power = {}

var skl = []
var skl_queue = []
var skl_rate = []

var data

signal end_turn()

func Set(enm):
	$Anim/Sprite.texture = load("res://image/%s.png"%enm.get("img","enm/Cultist-pretty"))
	data = enm
	mhp = enm.hp.val+randi()%int(enm.hp.rnd)
	hp = mhp
	skl = enm.get("skl",[]).duplicate(true)
	skl_queue = enm.get("skl_queue",[])
	skl_rate = enm.get("skl_rate",[])
	refresh_info()
	ShowAction()

func refresh_info():
	$EnemyUI/Info.Set(self)
	$EnemyUI/HP.Set(hp,mhp)
	$EnemyUI/Block/Label.text = str(blk)

var turn = 0
var cur_skl = null
func sel_skl():
	for queue in skl_queue:
		if queue.turn == turn:
			cur_skl = skl[queue.index]
			return cur_skl
	return skl[rndSelIndexByRate()]
	
func rndSelIndexByRate():
	var sum:int = 0
	for r in skl_rate:
		sum += r
	if sum == 0:
		return 0
	var roll = randi()%sum
	var count = 0
	for i in len(skl_rate):
		count += skl_rate[i]
		if count>=roll:
			return i
	return len(skl_rate)-1

func ShowAction():
	var skl = sel_skl()
	var dmg = 0
	for e in skl.efx:
		if e.type == "dmg":
			dmg += sklDmg(e)
	$EnemyUI/Intent.Set(skl,dmg)

func Action():
	blk = 0
	var skl = sel_skl()
	print("%s action use %s"%[enemy_name,str(skl.name)])
	for e in skl.efx:
		match e.type:
			"dmg":Attack(e)
			"blk":
				print_debug("Gain_Block:",e.val)
				blk+=e.val
			"str","dex":GlbAct.modDict(e,attr)
			"vul","weak","frail","entangle":
				print_debug("affix status:",e.type)
				GlbAct.GetChara().ModStatus(e)
			"script":
				print_debug("script:",str(e))
			_:print_debug("unknow efx:",str(e))
	emit_signal("end_turn")
	turn += 1

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
	
	return overDmg

func on_dead():
	#Play Dead Anim
	if get_parent().EnemyAllDead():
		GlbAct.BattleWin()
	yield(get_tree().create_timer(1),"timeout")
	queue_free()

func ModStatus(d):
	GlbAct.modDict(d,status)
	refresh_info()
