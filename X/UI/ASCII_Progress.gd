extends RichTextLabel

class_name ASCII_Progress

export var value = 0.5 setget set_val,get_val

func _ready():
	bbcode_enabled = true

func Set(value:float,length = 20):
	bbcode_text = "[center]%s"%GlbDat.GetProgressCode(value,length)

func set_val(value):
	Set(value)

func get_val():
	return value
