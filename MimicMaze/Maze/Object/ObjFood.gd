extends Area2D

func Trig(avatar,maze):
	GlbAudio.PlaySFX("res://Audio/UI/confirmation_002.ogg")
	avatar.TakeDamage(-10)
	queue_free()
