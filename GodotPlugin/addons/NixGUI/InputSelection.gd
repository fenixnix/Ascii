tool
extends PanelContainer

class_name InputSelection

export var label_text = "Label"

var label
var input:OptionButton

func _init():
	var box = HBoxContainer.new()
	label = Label.new()
	input = OptionButton.new()
	input.size_flags_horizontal = SIZE_EXPAND_FILL
	add_child(box)
	box.add_child(label)
	box.add_child(input)
	refresh()

func Setup(conf):
	input.clear()
	if conf!=null:
		label_text = conf.get("text","Label")
		for option in conf.get("selection",[]):
			input.add_item(option)
	refresh()

func Get():
	return input.text

func _process(delta):
	if Engine.editor_hint:
		refresh()

func refresh():
	label.text = label_text
