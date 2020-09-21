extends Control

signal select(index)

func Init(array):
	for c in $Menu.get_children():
		c.queue_free()
	yield(get_tree(),"idle_frame")
	var index = 0
	for a in array:
		var btn = Button.new()
		$Menu.add_child(btn)
		btn.text = a
		btn.connect("pressed",self,"on_click_menu",[index])
		index += 1
	show()

func on_click_menu(index):
	emit_signal("select",index)
	hide()
