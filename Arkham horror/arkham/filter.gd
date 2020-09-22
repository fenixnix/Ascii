extends HBoxContainer

signal update_filter(filter)

func _ready():
	for c in get_children():
		c.connect("pressed",self,"on_change")

func Get():
	var tmp = []
	for c in get_children():
		if c.pressed:
			tmp.append(c.name)
	return tmp

func on_change():
	emit_signal("update_filter",Get())
