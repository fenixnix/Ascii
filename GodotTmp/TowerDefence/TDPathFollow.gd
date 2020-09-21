extends PathFollow2D

class_name TDPathFollow

onready var follower

func _process(delta):
	offset += follower.mov_spd*delta
