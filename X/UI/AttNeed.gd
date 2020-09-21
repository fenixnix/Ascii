extends HBoxContainer

func Set(label,val,max_val,color = Color.white):
	$Label.text = label
	$Progress.value = val
	$Progress.max_value = max_val
	$Progress/Label.text = "%d/%d"%[val,max_val]
	modulate = color
