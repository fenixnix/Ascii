extends Node

class_name CameraShake

export var amplitude = 32

onready var target = get_parent()

func Shake(strength:float, duration:float = 0.6):
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_method(self,"SetOffset",strength,0,duration,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween.start()
	yield(tween,"tween_all_completed")
	tween.queue_free()

func SetOffset(strength:float):
	target.offset = Vector2(rand_range(-1,1),rand_range(-1,1))*strength


