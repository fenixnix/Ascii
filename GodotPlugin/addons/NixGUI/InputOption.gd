tool
extends PanelContainer

class_name InputOption

export var label_text = "Label"

var label
var root

func _init():
	var box = VBoxContainer.new()
	label = Label.new()
	root = GridContainer.new()
	root.size_flags_horizontal = SIZE_EXPAND_FILL
	root.size_flags_vertical = SIZE_EXPAND_FILL
	root.columns = 8
	add_child(box)
	box.add_child(label)
	box.add_child(root)
	refresh()

func Setup(conf):
	for c in root.get_children():
		c.queue_free()
	if conf!=null:
		label_text = conf.get("text","Label")
		for option in conf.get("options",[]):
			var ui = CheckBox.new()
			ui.text = option
			root.add_child(ui)
	refresh()

func Get():
	var tmp = []
	for c in root.get_children():
		if c.pressed:
			tmp.append(c.text)
	return tmp

func _process(delta):
	if Engine.editor_hint:
		refresh()

func refresh():
	label.text = label_text
