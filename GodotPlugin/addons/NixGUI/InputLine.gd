tool
extends PanelContainer

class_name InputLine

export var label_text = "Label"
export var place_holder = "place holder"
export var text = ""

var label
var input

func _init():
	var box = HBoxContainer.new()
	label = Label.new()
	input = LineEdit.new()
	input.size_flags_horizontal = SIZE_EXPAND_FILL
	add_child(box)
	box.add_child(label)
	box.add_child(input)
	refresh()

func Setup(conf):
	if conf!=null:
		label_text = conf.get("text","Label")
	refresh()

func _process(delta):
	if Engine.editor_hint:
		refresh()

func refresh():
	label.text = label_text
	input.placeholder_text = place_holder
	input.text = text
