extends CanvasLayer

signal select(dat)

func _ready():
	Clear()

func Test():
	Select(["OK","Cancel"],"Choice your selection:")
	
func Clear():
	for c in $Control/List.get_children():
		c.queue_free()

func Select(list,message = ""):
	Clear()
	yield(get_tree(),"idle_frame")
	$Control/Message.text = message
	$Control/OptionLabel.Select(list,message)
	$Control.show()
	$Anim.play("FadeIn")
	return self

func _on_Test_pressed():
	Test()

func _on_OptionLabel_select(index):
	print("on_select:",index)
	emit_signal("select",index)
	$Control.hide()
