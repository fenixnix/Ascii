extends Control

export(PackedScene) var shipLabelPrefab

onready var root = $PanelContainer/VBoxContainer/ScrollContainer/VBoxContainer

signal select(data)

var selectedData

func Set(ships):
	Clear()
	Refresh(ships)
	show()

func Refresh(ships):
	for s in ships:
		var lab  = shipLabelPrefab.instance()
		root.add_child(lab)
		lab.connect("select",self,"on_select")
		lab.Set(s)

func UpdateSelect():
	for c in root.get_children():
		c.modulate = Color.white

func Clear():
	for c in root.get_children():
		c.queue_free()

func on_select(lab):
	UpdateSelect()
	lab.modulate = Color(0,1,0)
	selectedData = lab.data

func _on_OK_pressed():
	emit_signal("select",selectedData)
	GlbUi.Pop()

func _on_Cancel_pressed():
	GlbUi.Pop()
