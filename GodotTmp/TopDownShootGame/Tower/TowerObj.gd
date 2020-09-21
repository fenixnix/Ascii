extends Node2D

export var team = 1

func AttackNearestTarget():
	for c in get_children():
		if c is Turrent:
			c.ShootNearestTarget()

func Shoot():
	AttackNearestTarget()
