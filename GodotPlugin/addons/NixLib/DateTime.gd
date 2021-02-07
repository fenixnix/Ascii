extends Label

export(String) var format = "%4d-%02d-%02d %02d:%02d:%02d"

func _process(delta):
	var dt = OS.get_datetime()
	text = format%[
		dt.year,dt.month,dt.day,
		dt.hour,dt.minute,dt.second
	]
