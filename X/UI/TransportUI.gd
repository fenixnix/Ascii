extends Control

var val_ui_prefab = preload("res://UI/SliderValue.tscn")

var data
onready var root = $Panel/Root

signal transport(data)

func Set(dat):
	data = dat
	for res in dat.keys():
		var ui = val_ui_prefab.instance()
		root.add_child(ui)
		ui.name = res
		ui.Set(GlbDb.icon_dict[res],data[res])

func Get():
	var tmp = {}
	for c in root.get_children():
		tmp[c.name] = c.Get()
	return tmp

func _on_OK_pressed():
	emit_signal("transport",Get())
