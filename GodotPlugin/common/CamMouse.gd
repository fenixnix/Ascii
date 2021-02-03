extends Camera2D

export var move_speed = 192

var keyboard = false
var active = false

var cam_zoom = 1
var cam_pos = Vector2.ZERO

var oriPos = Vector2()
var oriMousePos = Vector2()
var drag = false

func Event(event):
	if event is InputEventMouseButton:
		match event.button_index:
			1:
				oriPos = position
				oriMousePos = event.position
				drag = event.pressed
			4:cam_zoom *= 0.95
			5:cam_zoom *= 1.05
	
	if drag && event is InputEventMouseMotion:
		cam_pos = oriPos - (event.position-oriMousePos)*cam_zoom

func MoveTo(position,zoom = 1):
	cam_zoom = zoom
	cam_pos = position

func _process(delta):
	if keyboard:
		if Input.is_key_pressed(KEY_W):
			cam_zoom *= 0.95
		if Input.is_key_pressed(KEY_R):
			cam_zoom *= 1.05
	cam_zoom = clamp(cam_zoom,0.5,3)
	zoom = lerp(zoom,Vector2.ONE*cam_zoom,0.1)

	var offset = Vector2.ZERO
#	if Input.is_key_pressed(KEY_E):
#		offset.y -= 1
#	if Input.is_key_pressed(KEY_D):
#		offset.y += 1
#	if Input.is_key_pressed(KEY_S):
#		offset.x -= 1
#	if Input.is_key_pressed(KEY_F):
#		offset.x += 1
	cam_pos += offset*move_speed*delta*cam_zoom
	position = lerp(position,cam_pos,0.1)
