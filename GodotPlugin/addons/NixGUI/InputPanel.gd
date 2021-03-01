extends PanelContainer

var data = {}
onready var root = $VBoxContainer/Scroll/VBox

signal send(dat)

func Set(conf):
	for k in conf.keys():
		print(k)
		var value = conf[k]
		if !value.has("text"):
			value.text = k
		var ui = null
		match value.type:
			"str":
				ui = InputLine.new()
			"text":
				ui = InputMultiLine.new()
			"num":
				ui = InputNum.new()
			"bool":
				ui = InputBool.new()
			"sel":
				ui = InputSelection.new()
			"option":
				ui = InputOption.new()
			"img":pass
			_:pass
		if ui!=null:
			data[k] = ui
			ui.Setup(value)
			root.add_child(ui)

func Get():
	var tmp = {}
	for k in data:
		tmp[k] = data[k].Get()
	return tmp

func _on_ok_pressed():
	emit_signal("send",Get())

func _on_cancel_pressed():
	queue_free()
