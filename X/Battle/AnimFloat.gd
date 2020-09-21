extends Node

class_name AnimFloat

export var y_range = 8
export var speed = 2

var parent = null
var t = 0

func _ready():
	t = randf()*PI
	var p = get_parent()
	if p.get("offset")!=null:
		parent = p

func _process(delta):
	if parent==null:
		return
	t += delta*speed
	parent.offset = Vector2(0,sin(t))*y_range
