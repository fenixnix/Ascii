extends TextureProgress

func Set(val,val_max):
	value = val*100/val_max
	$Label.text = "%d/%d"%[val,val_max]
