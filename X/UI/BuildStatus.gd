extends VBoxContainer

func Set(dat):
	show()
	$Name.text = dat.name
	$Image.texture = load(dat.img)
	$ProgressBar.value = dat.progress*100
