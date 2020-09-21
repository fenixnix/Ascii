extends VBoxContainer

var data

signal select(data)

func _ready():
	yield(get_tree(),"idle_frame")
	Refresh()

func Set(dat):
	data = dat

func Refresh():
	$Label.text = data.name
	$Image.texture = load(data.img)

func _on_Image_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			emit_signal("select",data)
