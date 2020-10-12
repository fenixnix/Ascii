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
var cur_skl

var data

signal new_turn()
signal end_turn()
signal take_dmg(dmg)

func Set(enm):
	$Anim/Sprite.texture = load("res://image/%s.png"%enm.get("img","enm/Cultist-pretty"))
	data = enm
	mhp = enm.hp.val+randi()%int(enm.hp.rnd)
	hp = mhp
	if data.has("power"):
		for p in data.power.keys():
			ModPower(p,data.power[p])
	skl = enm.get("skl",[]).duplicate(true)
	skl_queue = enm.get("skl_queue",[])
	skl_rate = enm.get("skl_rate",[])
	refresh_info()

func refresh_info():
	$EnemyUI/Info.Set(self)
	$EnemyUI/HP.Set(hp,mhp)
	$EnemyUI/HP/Block/Label.text = str(blk)
	$EnemyUI/HP/Block.visible = blk!=0

var turn:int = 0
func NewTurn(_turn):
	turn = _turn
	cur_skl = sel_skl()
	emit_signal("new_turn",turn)

func EndTurn(_turn):
	#update status
	var dead_keys = []
	for k in status.keys():
		status[k] -= 1
		if status[k]<=0:
			dead_keys.append(k)
	for d in dead_keys:
		status.erase(d)
	refresh_info()

func sel_skl():
	for queue in skl_queue:
		if queue.turn == turn:
			return skl[queue.index]
	if data.has("skl_loop"):
		var index = posmod(turn,len(data.skl_loop))
		return skl[data.skl_loop[index]]
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
		if count>roll:
			return i
	return len(skl_rate)-1

func ShowAction():
	var skl = cur_skl
	print(cur_skl)
	var dmg = 0
	for e in skl.efx:
		if e.type == "dmg":
			dmg += sklDmg(e)
	$EnemyUI/Intent.Set(skl,dmg)

func Action():
	blk = 0
	$TextPartical.Play(cur_skl.name)
	print("%s action use %s"%[enemy_name,str(cur_skl.name)])
	for e in cur_skl.efx:
		match e.type:
			"dmg":Attack(e)
			"blk":GainBlock(e.val)
			"str","dex":GlbAct.modDict(e,attr)
			"vul","weak","frail","entangle":
				#print_debug("affix status:",e.type)
				GlbAct.GetChara().ModStatus(e)
			"power":ModPower(e.val.type,e.val.val)
			"script":
				var node = Node.new()
				node.set_script(load("res://script/enm_skl/%s.gd"%e.val))
				node.run(self,GlbAct.GetChara(),e.get("para",{}))
			_:print_debug("!!!unknow efx:",str(e))
	emit_signal("end_turn")

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
	emit_signal("take_dmg",_dmg)
	refresh_info()
	return overDmg

func on_dead():
	#Play Dead Anim
	if get_parent().EnemyAllDead():
		GlbAct.BattleWin()
	yield(get_tree().create_timer(1),"timeout")
	queue_free()

func ModPower(type,val):
	var node = Node.new()
	node.name = type
	add_child(node)
	var s = load("res://script/enm_power/%s.gd"%type)
	if s!=null:
		node.set_script(s)
		node.init(val)
	GlbAct.modDict({"type":type,"val":val},power)

func GainBlock(_blk):
	blk += _blk

func ModAttr(d):
	GlbAct.modDict(d,attr)
	refresh_info()

func ModStatus(d):
	if power.has("artifact"):
		GlbAct.modDict({"type":"artifact","val":-1},power)
	else:
		GlbAct.modDict(d,status)
	refresh_info()
