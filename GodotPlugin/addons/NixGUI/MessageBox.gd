extends Control

signal result

func _ready():
	pass

func Set(msg):
	$Frame/VBox/Label.text = msg
	$Frame/VBox/HBox/Cancel.show()

func Msg(msg):
	$Frame/VBox/HBox/Cancel.hide()
	$Frame/VBox/Label.text = msg

func _on_OK_pressed():
	emit_signal("result","ok")
	Close()

func _on_Cancel_pressed():
	emit_signal("result","cancel")
	Close()

func Close():
	queue_free()
