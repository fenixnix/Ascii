tool
extends PanelContainer

class_name InputOption

export var label_text = "Label"

var config = {}

var label
var content
var root

func _init():
	var box = VBoxContainer.new()
	label = Label.new()
	content = LineEdit.new()
	content.connect("text_changed",self,"on_line_value_change")
	root = GridContainer.new()
	root.size_flags_horizontal = SIZE_EXPAND_FILL
	root.size_flags_vertical = SIZE_EXPAND_FILL
	root.columns = 8
	add_child(box)
	box.add_child(label)
	box.add_child(content)
	box.add_child(root)
	refresh()

func Setup(conf):
	config = conf
	for c in root.get_children():
		c.queue_free()
	if conf!=null:
		label_text = conf.get("text","Label")
		refresh_options()
	refresh()

func refresh_options():
	for c in root.get_children():
		c.queue_free()
	var tmp_options = config.get("options",[])
	for o in Get():
		tmp_options.erase(o)
	for o in tmp_options:
		var ui = Button.new()
		ui.connect("pressed",self,"on_option_select",[o])
		ui.text = o
		root.add_child(ui)

func on_line_value_change(_value):
	refresh_options()
	update()

func on_option_select(option):
	if content.text!="":
		content.text += ","
	content.text += option
	content.update()
	refresh_options()

func Get():
	return content.text.split(',')

func _process(delta):
	pass
#	if Engine.editor_hint:
#		refresh()

func refresh():
	label.text = label_text
