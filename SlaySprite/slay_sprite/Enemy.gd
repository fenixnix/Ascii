extends Node2D

var hp = 0
var skills = []

signal select(target)

func _on_Area2D_mouse_entered():
	if GlbUi.is_dragging:
		GlbUi.target = self

func _on_Area2D_mouse_exited():
	pass # Replace with function body.

func _on_Area2D_input_event(viewport, event:InputEvent, shape_idx):
	if event.is_action_released("click"):
		print(event)
		if GlbUi.is_dragging:
			emit_signal("select",self)
			print_debug("select:",self)
