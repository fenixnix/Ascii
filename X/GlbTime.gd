extends Node

var day:int = 0
var hour:int = 0
var sec = 0

var running = true

signal hour_tick()
signal day_tick()

func _physics_process(delta):
	if !running:
		return
	sec += delta
	if sec>hour+1:
		hour = floor(sec)
		emit_signal("hour_tick")
	if hour/24>day:
		day = floor(hour/24)
		emit_signal("day_tick")

func PrintDateTime():
	return "Day: %d  %02d:%02d"%[floor(sec/24),int(floor(sec))%24,floor((sec-floor(sec))*60)]
