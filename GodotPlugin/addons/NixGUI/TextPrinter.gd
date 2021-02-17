extends RichTextLabel

class_name TextPrinter,"res://addons/NixGUI/icon/icon_print_text.svg"

var delayTime = 0.1
var timer

signal putChar()
signal finish()
signal wait()

func _enter_tree():
	bbcode_enabled = true
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout",self,"on_timeout")
	connect("gui_input",self,"on_gui_input")

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
