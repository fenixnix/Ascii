extends CanvasLayer

var stack = []

func Load(file):
	var ui = load(file).instance()
	return Push(ui)

func Push(ui):
	add_child(ui)
	if len(stack)>0:
		stack.back().hide()
	stack.push_back(ui)
	return ui

func Pop():
	if len(stack)>0:
		stack.pop_back().queue_free()
	if len(stack)>0:
		stack.back().show()
