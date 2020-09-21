extends CanvasLayer

func _ready():
	StarMap()
	$MainUI.show()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		StarMap()

func _on_Map_pressed():
	StarMap()

func StarMap():
	pass
