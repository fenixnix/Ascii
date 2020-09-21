extends CanvasLayer

export(PackedScene) var sklIconPrefab

signal select_targets(caster,skill)

func UpdateActionQueue(queue):
	for c in $Queue.get_children():
		c.queue_free()
	yield(get_tree(),"idle_frame")
	for q in queue:
		var lab = TextureRect.new()
		lab.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		lab.expand = true
		lab.rect_min_size = Vector2(64,64)
		$Queue.add_child(lab)
		lab.texture = load(q.data.img)

var currentUnit

func SetSkill(unit):
	currentUnit = unit
	for c in $Skills.get_children():
		c.queue_free()
	append_skill({
		"name":"Evade",
		"img":"res://Battle/image/icon/passturn.png",
		"anim":"res://Battle/BattleEffect/BuffEvade.tscn",
		"efx":[]
		})
	for w in unit.data.wpns:
		append_skill(w)
	$Skills.show()

func append_skill(dat):
	var wpn = sklIconPrefab.instance()
	wpn.Set(dat)
	$Skills.add_child(wpn)
	wpn.connect("select",self,"on_select_skill_icon")
	wpn.connect("enter",self,"on_enter_skill_icon")
	wpn.connect("exit",self,"on_exit_skill_icon")

func on_select_skill_icon(data):
	emit_signal("select_targets",currentUnit,data)
	$Skills.hide()
	$SklStatusPanel.hide()	

func on_exit_skill_icon():
	$SklStatusPanel.hide()

func on_enter_skill_icon(dat):
	$SklStatusPanel.Set(dat)
