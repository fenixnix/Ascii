extends Area2D

enum GateState{ready,locked,open}

var state = GateState.ready

func Trig(avatar,maze):
	if state == GateState.ready:
		GlbAudio.PlaySFX("res://Audio/UI/confirmation_002.ogg")
		maze.Win()
		state = GateState.open

func Active():
	state = GateState.ready
