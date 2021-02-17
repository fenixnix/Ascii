extends RichTextLabel

class_name RichTextLabelEx,"res://addons/NixGUI/icon/icon_print_text.svg"

export var delayTime = 0.1
var timer

signal putChar()
signal finish()
signal wait()

signal select(index)

func _enter_tree():
	_ready()

func _ready():
	bbcode_enabled = true
	fit_content_height = true
	scroll_active = false
	connect("meta_clicked",self,"on_meta")
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout",self,"on_timeout")
	connect("gui_input",self,"on_gui_input")

func Select(list, desc = ''):
	clear()
	parse_bbcode(desc)
	newline()
	push_selection(list)

func push_selection(list):
	var index = 0
	for l in list:
		push_align(RichTextLabel.ALIGN_CENTER)
		push_meta(index)
		push_underline()
		add_text(tr(l)+'\n')
		pop()
		newline()
		index += 1

func on_meta(meta):
	#print_debug("select:%d"%meta)
	emit_signal("select",meta)

func Print(txt):
	if visible_characters < len(text):
		visible_characters = len(text)
	append_bbcode(txt)
	timer.start(delayTime)

func put():
	#$TypeSFX.play()
	emit_signal("putChar")
	if visible_characters >= len(text):
		timer.stop()
		emit_signal("wait")
		return
	visible_characters += 1

func Clear():
	clear()
	visible_characters = 0

func on_timeout():
	put()

func Click():
	if visible_characters<len(text):
		visible_characters = len(text)
	else:
		emit_signal("finish")

func on_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			Click()
