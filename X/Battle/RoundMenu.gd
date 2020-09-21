extends Control

var list = ["A","B","C","D","E","F"]

export var size = 2

var offset = [-2,-1,0,1,2]
var currentIndex = 0

func _ready():
	offset.clear()
	for i in range(-size,size+1):
		offset.append(i)
	print(offset)
	for c in $Menu.get_children():
		c.queue_free()
	yield(get_tree(),"idle_frame")
	for i in len(offset):
		var lab = Button.new()
		lab.align = Button.ALIGN_CENTER
		lab.size_flags_horizontal = SIZE_EXPAND
		lab.text = "null"
		$Menu.add_child(lab)

func Left():
	mov(-1)

func Right():
	mov(1)

func mov(ref):
	currentIndex += ref
	currentIndex = posmod(currentIndex,len(offset))
	var ori = $Menu.rect_position
	$Tween.interpolate_property($Menu,"rect_position",$Menu.rect_position,$Menu.rect_position - Vector2(rect_size.x/(len(offset))*ref,0),.1,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	$Menu.rect_position = ori
	Refresh()

func getArray():
	var arr = []
	for o in offset:
		var index = posmod(o+currentIndex,len(list))
		arr.append(list[index])
	return arr

func Refresh():
	var arr = getArray()
	for i in len(offset):
		$Menu.get_child(i).text = arr[i]
