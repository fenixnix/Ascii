tool
extends PanelContainer

class_name InputBool

export var label_text = "Label"
export var check:bool = false

var checkBtn:CheckButton

func _init():
	checkBtn = CheckButton.new()
	add_child(checkBtn)
	refresh()

func Setup(conf):
	if conf!=null:
		label_text = conf.get("text","Label")
		checkBtn.pressed = conf.get("default",false)
	refresh()

func _process(delta):
	if Engine.editor_hint:
		refresh()

func refresh():
	checkBtn.text = label_text
	checkBtn.pressed = check
