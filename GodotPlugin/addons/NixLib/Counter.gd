extends Node

class_name Counter

export var repeat = true

var running = false
var count_max = 1
var count = 0

signal time_out

func Start(val):
	count_max = val
	count = 0
	running = true

func Stop():
	count = 0
	running = false

func Count(val = 1):
	if !running:
		return
	count += val
	if count>=count_max:
		emit_signal("time_out")
		if repeat:
			Start(count_max)
		else:
			Stop()
