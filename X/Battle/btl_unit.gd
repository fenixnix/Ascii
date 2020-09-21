extends Spatial

class_name btl_unit

var data

var cam
var hud setget set_hud
var dead = false

var select_mode setget set_select
var active_mode setget set_active

signal select()

func Set(dat):
	data = dat
	$Sprite3D.texture = load(dat.img)
	hud.Set(dat)

func _process(delta):
	if dead:
		return
	if cam == null || hud == null:
		return
	var screen_pos = cam.unproject_position(global_transform.origin)
	hud.set_position(screen_pos)

func set_hud(_hud):
	hud = _hud

func set_select(val):
	$Area.visible = val
	$Sprite3D.shaded = !val
	
func set_active(val):
	pass

func Tick():
	for w in data.wpns:
		if w.has('cd'):
			w.cd -= 1
			if w.cd<0:
				w.cd = 0
		if w.has("wu"):
			w.wu -= 1
			if w.wu<=0:
				w.erase("wu")
	process_EOT()

func process_EOT():
	#TODO: process effect over time
	pass

func TakeDamage(dmg):
	data.hp -= dmg/data.status.hull
	hud.Set(data)
	if data.hp<=0:
		Destory()
	return dmg

func Destory():
	dead = true
	hud.queue_free()
	yield(get_tree().create_timer(1.5),"timeout")
	print("%s destory"%[data.name])
	$anim.play("dead")

func GetReadyWpns():
	var lst = []
	for wpn in data.wpns:
		if wpn.get("cd",0) == 0 && wpn.get("wu",0) == 0 && wpn.get("ammo",-1)!=0:
			lst.append(wpn)
	return lst

func GetRandomReadyWeapon():
	var lst = GetReadyWpns()
	var size = len(lst)
	if size<=0:
		return null
	return lst[randi()%size]

func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if $Area.visible:
		if event is InputEventMouseButton && event.button_index == 1 && event.pressed:
			emit_signal("select")

func _on_Area_mouse_entered():
	GlbUi.OverlapUI("BtlInfo",data)

func _on_Area_mouse_exited():
	GlbUi.Pop()
