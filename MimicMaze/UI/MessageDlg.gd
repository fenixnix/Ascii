extends Control

signal selected(index)

func Exec(title,list,msg):
	for c in $Menu.get_children():
		c.queue_free()
	for i in len(list):
		var btn = Button.new()
		$Menu.add_child(btn)
		btn.connect("pressed",self,"on_select",[i])
		btn.text = list[i]
	$Title.text = title
	$Message.text = msg
	show()
	yield(get_tree(),"idle_frame")
	$Menu.get_child(0).grab_focus()

func on_select(index):
	emit_signal("selected",index)
	hide()
