extends Node

func GetData():
	return {
		"w":$Size/W.value,"h":$Size/H.value,"d":$Size/D.value,
		"algorithm":$Algorithm.selected,"fog":$Fog.pressed,
		"cam_follow":$CamFollow/Follow.pressed,"zoom":$CamFollow/Zoom.value,
		"key":$Key.pressed,
		"food":$Food.pressed,
		"enemy":$Enemy.pressed,
		}


func _on_Zoom_value_changed(value):
	$CamFollow/SpinBox.value = value


func _on_SpinBox_value_changed(value):
	$CamFollow/Zoom.value = value
