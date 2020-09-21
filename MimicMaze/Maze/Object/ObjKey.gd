extends Area2D

func Trig(avatar,maze):
	GlbAudio.PlaySFX("res://Audio/UI/confirmation_002.ogg")
	for c in get_parent().get_children():
		if c.script.name == "ObjGoal":
			c.Active()
	queue_free()
