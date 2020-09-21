extends Control

var data

signal cancel_task(data)

func Set(dat):
	data = dat
	$Panel/TaskRT.Set(data)

func _on_ExploreCancelBtn_pressed():
	emit_signal("cancel_task",data)
