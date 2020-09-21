extends TextureRect

var data

signal enter(dat)
signal exit(dat)
signal select(dat)

func Set(dat):
	data = dat
	texture = load(dat.get("icon","res://images/icon/icon_dice.png"))
	var warmUp = dat.get("wu",0)>0
	$WarmUp.visible = warmUp
	if warmUp:
		$WarmUp/Label.text = str(dat.get("wu",0))
	var cd = dat.get("cd",0)>0
	$CoolDown.visible = cd
	if cd:
		$CoolDown/Label.text = str(dat.get("cd",0))
	$Count.visible = !warmUp&&!cd
	if dat.get("ammo",-1)==-1:
		$Count.hide()
	else:
		$Count.text = str(dat.ammo)
	if dat.get("ammo",-1) == 0:
		modulate = Color.gray

func _on_SklIcon_mouse_entered():
	emit_signal("enter",data)

func _on_SklIcon_mouse_exited():
	emit_signal("exit")

func _on_SklIcon_gui_input(event):
	if event is InputEventMouseButton && event.button_index == 1 && event.pressed:
		emit_signal("select",data)
