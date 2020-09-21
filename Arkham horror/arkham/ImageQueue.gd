extends TextureRect

class_name ImageQueue

var queue = []
var curIndex = 0

func _ready():
	connect("gui_input",self,"on_gui")

func Clear():
	queue.clear()

func Append(img):
	queue.append(img)
	refresh()

func refresh():
	texture = queue[curIndex]

func on_gui(event:InputEvent):
	if event.is_action_pressed("click"):
		curIndex = posmod(curIndex+1,len(queue))
		refresh()
