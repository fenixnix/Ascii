extends Camera

var active = false

var cam_zoom = 1
var cam_pos = Vector3.ZERO

var oriPos = Vector3()
var oriMousePos = Vector2()
var drag = false

var drag_rot = false
var drag_tra = false

func Event(event:InputEvent):
	var offset = Vector3.ZERO
	if event is InputEventMouseButton:
		match event.button_index:
#			1:
#				#oriPos = position
#				oriMousePos = event.position
#				drag = event.pressed
#				drag_rot = event.pressed
			2:
				oriPos = translation
				oriMousePos = event.position
				drag_tra = event.pressed
			4:offset += Vector3.FORWARD
			5:offset += Vector3.BACK
	
	if event is InputEventMouseMotion:
		if drag_tra:
			offset += Vector3(
				oriMousePos.x - event.position.x,
				-oriMousePos.y + event.position.y,
				0)/64
	
	#print(oriMousePos,event.position)
#	if drag && event is InputEventMouseMotion:
#		cam_pos = oriPos - (event.position-oriMousePos)*cam_zoom
	cam_pos = oriPos + offset
	#translate(offset)
	
func MoveTo(position):
	cam_zoom = 1
	cam_pos = position

func _process(delta):
	translation = lerp(translation,cam_pos,0.1)
#	var offset = Vector2.ZERO
#	if Input.is_key_pressed(KEY_E):
#		offset.y -= 1
#	if Input.is_key_pressed(KEY_D):
#		offset.y += 1
#	if Input.is_key_pressed(KEY_S):
#		offset.x -= 1
#	if Input.is_key_pressed(KEY_F):
#		offset.x += 1
	#cam_pos += offset*move_speed*delta*cam_zoom
	#position = lerp(position,cam_pos,0.1)
