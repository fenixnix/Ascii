extends Node2D

var HP = 20

signal attack_finish()

func Attack():
	yield(get_tree().create_timer(3),"timeout")
	print("Attack!!!")
	emit_signal("attack_finish")
