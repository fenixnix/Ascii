extends Node

class_name UnitLife

export var DestoryOnDead = true
export var maxLife = 3
var life = 3

signal dead
signal take_damage(dmg)

func _ready():
	life = maxLife

func TakeDamage(dmg):
	emit_signal("take_damage",dmg)
	life -= dmg
	if life<=0:
		life = 0
		emit_signal("dead")
		if DestoryOnDead:
			get_parent().queue_free()

func Add(val):
	life = clamp(life+val,0,maxLife)

func Restore():
	life = maxLife
