extends Sprite

func _on_Label_mouse_entered():
	$label/Label.text = "show"
	$label.show()

func _on_Label_mouse_exited():
	$label.hide()

func _on_area_gui_input(event):
	if event.is_action_pressed("click"):
		$select.show()
		$select.play()
		yield($select,"animation_finished")
		$select.stop()
		$select.frame = 4
		#$select.hide()
