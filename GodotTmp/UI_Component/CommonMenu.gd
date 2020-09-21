extends Control

export(Array,String) var options = []

var data = {}

signal pressed(id)

func _ready():
	Init(options)

func Init(dat):
	for c in get_children():
		c.queue_free()
	for d in dat:
		var btn = Button.new()
		add_child(btn)
		btn.text = tr(d)
		btn.connect("pressed",self,"on_press_button",[d])

func on_press_button(id):
	emit_signal("pressed",id)
