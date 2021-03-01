extends PanelContainer

var data
onready var root = $Scroll/VBox

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
			"num":
				ui = InputNum.new()
			"bool":
				ui = InputBool.new()
			"text":
				ui = InputText.new()
			"sel":
				ui = InputSelection.new()
			_:pass
		if ui!=null:
			ui.Setup(value)
			root.add_child(ui)
