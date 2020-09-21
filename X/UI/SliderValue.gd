extends HBoxContainer

func Set(icon,max_val,min_val = 0):
	$Icon.texture = load(icon)
	$max.text = str(max_val)
	$HSlider.editable = max_val!=0
	$SpinBox.editable = max_val!=0
	$HSlider.min_value = min_val
	$SpinBox.min_value = min_val
	if max_val != 0:
		$HSlider.max_value = max_val
		$SpinBox.max_value = max_val

func Get():
	if $SpinBox.min_value == $SpinBox.max_value:
		return 0
	else:
		return $SpinBox.value

func _on_SpinBox_value_changed(value):
	$HSlider.value = value
	$max.text = str($HSlider.max_value-value)

func _on_HSlider_value_changed(value):
	$SpinBox.value = value
