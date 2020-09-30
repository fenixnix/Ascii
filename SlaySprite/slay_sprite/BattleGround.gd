extends Node2D

onready var enm_prefab = preload("res://Enemy.tscn")

func Clear():
	for c in get_children():
		c.queue_free()

func AddEnm(_enm):
	var enm:Enemy = enm_prefab.instance()
	add_child(enm)
	enm.Set(_enm)

func EnemyPhase():
	for c in get_children():
		c.Action()

func ShowEnmAction():
	for c in get_children():
		c.ShowAction()

func EnemyAllDead():
	for c in get_children():
		if c.hp>0:
			return false
	return true
