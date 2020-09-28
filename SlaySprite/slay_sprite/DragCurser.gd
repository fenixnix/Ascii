extends Control

var ori = Vector2.ZERO

func Set(ori_pos):
	ori = ori_pos

func _process(delta):
	$Line2D.points[1] = ori-rect_position
