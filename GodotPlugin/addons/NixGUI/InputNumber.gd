tool
extends PanelContainer

class_name InputNumber,"res://addons/NixGUI/icon/icon_file_list.svg"

export var text = "label"
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
	#label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	spin = SpinBox.new()
	spin.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	box.add_child(label)
	box.add_child(spin)

func _ready():
	refresh()

func _process(delta):
	if Engine.editor_hint:
		refresh()

func refresh():
	label.text = text
	spin.value = value
	spin.max_value = max_value
	spin.min_value = min_value
	spin.step = step
