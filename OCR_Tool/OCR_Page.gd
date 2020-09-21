extends TextureRect

signal select_roi(roi)

export(Font) var font

var start_point
var painting = false

var data = null

func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 && event.pressed:
			start_point = get_local_mouse_position()
			painting = true
			print("start")
		if event.button_index == 1 && !event.pressed:
			painting = false
			var end_point = get_local_mouse_position()
			if end_point.x > start_point.x && end_point.y > start_point.y:
				emit_signal("select_roi",Rect2(start_point,end_point-start_point))
		
	if event is InputEventMouseMotion && painting:
		update()

func DrawDatas(_data):
	data = _data
	update()

func _draw():
	if painting == true:
		draw_rect(Rect2(start_point,get_local_mouse_position()-start_point),Color.green,false)
	if data!=null:
		for d in data:
			draw_rect(d.roi,Color.gold,false)
			draw_string(font,d.roi.position+Vector2.UP,d.key)
