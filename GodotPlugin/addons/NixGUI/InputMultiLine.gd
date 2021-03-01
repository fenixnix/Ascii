tool
extends PanelContainer

class_name InputMultiLine

export var label_text = "Label"
export var text = ""

var label
var input

func _init():
	var box = VBoxContainer.new()
	label = Label.new()
	input = TextEdit.new()
	input.size_flags_horizontal = SIZE_EXPAND_FILL
	input.rect_min_size.y = 80
	add_child(box)
	box.add_child(label)
	box.add_child(input)
	refresh()

func Setup(conf):
	if conf!=null:
		label_text = conf.get("text","Label")
	refresh()

func Get():
	return input.text

func _process(delta):
	if Engine.editor_hint:
		refresh()

func refresh():
	label.text = label_text
	input.text = text
