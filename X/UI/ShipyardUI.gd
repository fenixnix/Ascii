extends Control

var data

func Set(info):
	data = info
	Refresh()

func Refresh():
	$Build.Set(data)

func _on_Build_build_ship(ship):
	Refresh()
