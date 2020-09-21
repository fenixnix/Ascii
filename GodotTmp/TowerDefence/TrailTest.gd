extends Node2D

func _on_Button_pressed():
	$Camera2D_Zoom/AnimShake.Shake($UI/HBoxContainer/SpinBox.value)
	pass
