extends Control

var data

func Set(dat):
	data = dat
	$ScrollContainer/Info.Set(data)

func _on_Exit_pressed():
	GlbUi.Pop()

func _on_Region_pressed():
	GlbUi.PushUI("RegionUI",data)
