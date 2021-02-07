extends Control

signal send(txt)

func Open():
	$Frame/VBox/LineEdit.clear()
	show()

func _on_Cancel_pressed():
	hide()

func _on_OK_pressed():
	emit_signal("send",$Frame/VBox/LineEdit.text)
	hide()
