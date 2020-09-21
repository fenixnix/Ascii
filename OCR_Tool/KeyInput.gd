extends PopupPanel

signal finish(key,type)

func _on_Key_text_entered(new_text):
	emit_signal("finish",new_text,$HBoxContainer/Type.text)
	$HBoxContainer/Key.clear()
	hide()
