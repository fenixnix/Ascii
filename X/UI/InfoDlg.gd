extends Control

func Set(dat):
	$bg/info.set_script(load(dat.script))
	$bg/info.Set(dat.data)
	$bg/info.Init()

func _on_OK_pressed():
	GlbUi.Pop()
