extends Control

var data

signal select(ofc)

func Init():
	pass

func Set(ofcLst):
	data = ofcLst
	for l in $List.get_children():
		l.queue_free()
	var index = 0
	for ofc in ofcLst:
		var lab = OfcInfoRT.new()
		lab.size_flags_horizontal = 3
		lab.size_flags_vertical = 3
		lab.connect("gui_input",self,"on_gui_input",[index])
		lab.connect("mouse_entered",self,"on_enter",[lab])
		lab.connect("mouse_exited",self,"on_exit",[lab])
		$List.add_child(lab)
		lab.Set(ofc)
		index += 1

func on_gui_input(event,index):
	if event is InputEventMouseButton && event.button_index == 1 && event.pressed:
		emit_signal("select",data[index])
		GlbUi.Pop()

func on_enter(lab):
	lab.modulate = Color("#80ffff")

func on_exit(lab):
	lab.modulate = Color.white
