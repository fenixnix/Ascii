extends Node2D

export var mov_spd = 64

var team = 0

func _ready():
	$AnimationPlayer.play("Walk")
