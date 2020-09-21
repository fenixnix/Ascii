extends Node

var action_queue = []
var turn = 0
var retreat = false
var running = false

signal battle_result(result)

var plrLst
var enmLst

func Start(dat):
	plrLst = $BattleField.AssetPlayers(dat.plr)
	enmLst = $BattleField.AssetEnemys(dat.enm)
	running = true
	RoundTick()

func RoundTick():
	action_queue = AssetActionQueue()
	$UI.UpdateActionQueue(action_queue)
	
	for u in action_queue:
		if u.dead:
			continue
		if u.data.get("team",0) == 0:
			if retreat:
				running = false
				continue
			$UI.SetSkill(u)
			$BattleField.LookAt(u)
			var res = yield($BattleField,"select_skill_and_targets")
			if retreat:
				running = false
				continue
			yield(Action(u,res[0],res[1]),"completed")
			$BattleField.BackToOri()
			$UI/Skills.hide()
		else:
			yield(AI_Action(u),"completed")

		yield(get_tree().create_timer(0.5),"timeout")
		if check_battle_result():
			running = false
			return
	
	if retreat:
		process_result("retreat")
	if !running:
		return
	turn += 1
	$BattleField.RoundTick()
	RoundTick()

func AssetActionQueue():
	var tmpList = []
	append_list(plrLst,tmpList)
	append_list(enmLst,tmpList)
	tmpList.sort_custom(MyCustomSorter,"sort_ascending")
	return tmpList

func append_list(src,dst):
	for u in src:
		if u.dead:
			continue
		var dat = u.data
		if dat.hp>0:
			dat.tmp_spd = dat.status.spd*rand_range(1,1.2)
			dst.append(u)

class MyCustomSorter:
	static func sort_ascending(a, b):
		if a.data.tmp_spd < b.data.tmp_spd:
			return true
		return false


func AI_Action(unit):
	#uniform data
	var wpn = unit.GetRandomReadyWeapon()
	if wpn==null:
		print("%s skip round..."%[unit.name])
	else:
		var lst = $BattleField.GetSelectableTargets(unit,wpn,true)
		if wpn.select.sel == "single":
			Action(unit,wpn,[lst[randi()%len(lst)]])
		else:
			Action(unit,wpn,lst)
	yield(get_tree().create_timer(.5),"timeout")

func Action(caster,skill,targets):
	print("%s use %s"%[caster.name,skill.name])
	var prefab = load(skill.get("anim","res://Battle/BattleEffect/ion.tscn"))
	for t in targets:
		var anim = prefab.instance()
		caster.add_child(anim)
		var res = ProcessSkill(caster,skill,t)
		$BattleField/Camera/SpatialFloatText.Play(t.translation,res)
		anim.Play(t)
	yield(get_tree().create_timer(1),"timeout")

func ProcessSkill(caster,skill,target):
	#cost ammo & into cooldown
	if skill.has("max_cd"):
		skill.cd = skill.max_cd + 1
	if skill.has("ammo"):
		skill.ammo -= 1
		
	var txt = ""
	for e in skill.efx:
		match e.type:
			"dmg":
				var dmg = Weapon.RollDamage(e)
				target.TakeDamage(dmg)
				txt += str(dmg)
			_:print("no process skill")
	return txt

func check_battle_result():
	if no_survival($BattleField/PLR):
		process_result("loss")
		return true
	if no_survival($BattleField/ENM):
		process_result("win")
		return true

func process_result(res):
	emit_signal("battle_result",{
	"result":res,
	"plr_hps":get_hps(plrLst),
	"enm_hps":get_hps(enmLst),
	})

func get_hps(team):
	var tmpLst = []
	for u in team:
		if is_instance_valid(u) && u is btl_unit:
			tmpLst.append(u.data.hp)
		else:
			tmpLst.append(0)
	return tmpLst

func no_survival(root):
	for u in root.get_children():
		if u is btl_unit && !u.dead:
			return false
	return true

func _on_Retreat_pressed():
	retreat = true
	$BattleField.emit_signal("select_skill_and_targets")
	$BattleField.BackToOri()
	$UI/Skills.hide()

func _on_Win_pressed():
	running = false
	for u in enmLst:
		u.data.hp = 0
	process_result("win")

func _on_Loss_pressed():
	running = false
	process_result("loss")
