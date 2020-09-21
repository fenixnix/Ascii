extends HBoxContainer

signal value_change(vec)

func Init(id,vec):
	$ID.text = id
	$X.value = vec.x
	$Y.value = vec.y

func _on_X_value_changed(value):
	emit_signal("value_change",Vector2($X.value,$Y.value))

func _on_Y_value_changed(value):
	emit_signal("value_change",Vector2($X.value,$Y.value))
