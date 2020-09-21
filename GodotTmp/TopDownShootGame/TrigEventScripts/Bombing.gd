extends Node

func Trig(root):
	$Bombers.show()
	$AnimationPlayer.play("Play")
	yield($AnimationPlayer,"animation_finished")
	$Bombers.hide()
