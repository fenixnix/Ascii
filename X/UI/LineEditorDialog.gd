extends PopupPanel

signal value_change(new_text)

func _on_LineEdit_text_changed(new_text):
	#emit_signal("value_change",new_text)
	pass

func _on_LineEdit_text_entered(new_text):
	emit_signal("value_change",new_text)
	queue_free()
