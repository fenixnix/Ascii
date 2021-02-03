extends Label

func _process(delta):
	var dt = OS.get_datetime()
	text = "%4d-%2d-%2d\n%02d:%02d:%02d"%[
		dt.year,dt.month,dt.day,
		dt.hour,dt.minute,dt.second
	]
