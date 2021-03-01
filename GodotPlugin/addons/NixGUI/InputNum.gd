tool
extends PanelContainer

class_name InputNum,"res://addons/NixGUI/icon/icon_file_list.svg"

export var label_text = "label"
export var value = 0
export var max_value = 100
export var min_value = 0
export var step = 1.0

var label
var spin

func _init():
	var box = HBoxContainer.new()
	add_child(box)
	label = Label.new()
	spin = SpinBox.new()
	spin.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	box.add_child(label)
	box.add_child(spin)

func Setup(conf):
	if conf!=null:
		label_text = conf.get("text","Label")
		value = conf.get("default",0)
		min_value = conf.get("min",0)
		max_value = conf.get("max",65535)
		step = conf.get("step",1)
	refresh()

func _process(delta):
	if Engine.editor_hint:
		refresh()

func refresh():
	label.text= label_text
	spin.value = value
	spin.max_value = max_value
	spin.min_value = min_value
	spin.step = step
