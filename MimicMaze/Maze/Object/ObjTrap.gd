extends Area2D

var color = Color.red
var points = [Vector2(0,-8),Vector2(-4,0),Vector2(4,0)]

func _draw():
	draw_colored_polygon(points,color)
	update()

func Trig(avatar,maze):
	GlbAudio.PlaySFX("res://Audio/UI/confirmation_002.ogg")
	avatar.TakeDamage(10)
	queue_free()

