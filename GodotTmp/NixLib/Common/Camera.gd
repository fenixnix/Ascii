extends Camera2D

class_name Camera2D_Zoom

export var minZoom = 0.3
export var maxZoom = 5
var zoomVal = 1

func _input(event):
	if event.is_action_pressed("zoomIn"):
		zoomVal*=1.1
	if event.is_action_pressed("zoomOut"):
		zoomVal*=0.9
	zoomVal = clamp(zoomVal,minZoom,maxZoom)
	zoom = Vector2.ONE*zoomVal
	
