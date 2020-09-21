extends TextureProgress

func Set(val,_max_val,color = Color.white):
	$Label.text = str(val)
	value = val
	min_value = 0
	max_value = _max_val
	self_modulate = color
