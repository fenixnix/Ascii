tool
extends PanelContainer

class_name InputNumber,"res://addons/NixGUI/icon/icon_file_list.svg"

export var text = "label"
export var value = 0
export var max_value = 100
export var min_value = 0
export var step = 1.0

func _ready():
	$Box/Label.text = text
	$Box/spin.value = value
	$Box/spin.max_value = max_value
	$Box/spin.min_value = min_value
	$Box/spin.step = step
