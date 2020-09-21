extends Spatial

export(PackedScene) var unitPrefab
export(PackedScene) var unitHUDPrefab

var offset = Vector3(0,-1,1)

#var dict = {}

signal select_skill_and_targets(skl,targets)

func AssetPlayers(ships):
	var tmplst = []
	var origin = (len(ships)-1) * offset / 2 * -1
	for i in range(len(ships)):
		var unit = CreateUnit(ships[i],origin + i * offset+Vector3(3,0,0))
		$PLR.add_child(unit)
		tmplst.append(unit)
		unit.get_node("Sprite3D").flip_h = true
	return tmplst
	
func AssetEnemys(ships):
	var tmplst = []
	var origin = (len(ships)-1) * offset / 2 * -1
	for i in range(len(ships)):
		var unit = CreateUnit(ships[i],origin + i * offset+Vector3(-3,0,0))
		tmplst.append(unit)
		$ENM.add_child(unit)
	return tmplst

func CreateUnit(ship_dat,position):
	var unit  = unitPrefab.instance()
	unit.translation = position
	unit.cam = $Camera
	unit.hud = unitHUDPrefab.instance()
	unit.Set(ship_dat)
	$HUD.add_child(unit.hud)
	unit.connect("select",self,"on_select",[unit])
	return unit

func RoundTick():
	for u in $PLR.get_children():
		u.Tick()
	for u in $ENM.get_children():
		u.Tick()

var lookOffset = Vector3(0,0,5)
func LookAt(unit):
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property($Camera,"translation",
	$Camera.translation,
	unit.global_transform.origin + lookOffset,.5,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.start()
	yield(tween,"tween_all_completed")
	tween.queue_free()

func BackToOri():
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property($Camera,"translation",
	$Camera.translation,
	$cam_ori.translation,.5,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.start()
	yield(tween,"tween_all_completed")
	tween.queue_free()

#type enm aly self
#range single multiply random
var currentSkill
var targets = []
func SelectTargets(caster,skill_dat):
	BackToOri()
	ClearSelect()
	currentSkill = skill_dat
	targets.clear()
	targets = GetSelectableTargets(caster,skill_dat)
	for t in targets:
		t.select_mode = true

func ClearSelect():
	for u in $PLR.get_children():
		u.select_mode = false
	for u in $ENM.get_children():
		u.select_mode = false

func GetSelectableTargets(caster,skill_dat,ai=false):
	var lst = []
	for t in skill_dat.get("affix",["self"]):
		match t:
			"aly":
				if ai:
					for c in $ENM.get_children():
						if !c.dead:
							lst.append(c)
				else:
					for c in $PLR.get_children():
						if !c.dead:
							lst.append(c)
			"enm":
				if ai:
					for c in $PLR.get_children():
						if !c.dead:
							lst.append(c)
				else:
					for c in $ENM.get_children():
						if !c.dead:
							lst.append(c)
			"self":lst.append(caster)
	return lst

func on_select(unit):
	for t in targets:
		t.select_mode = false
		
	match currentSkill.get("select","single"):
		"single":emit_signal("select_skill_and_targets",currentSkill,[unit])
		"multi":emit_signal("select_skill_and_targets",currentSkill,targets)
		#"random":pass
