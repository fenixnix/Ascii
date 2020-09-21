extends CanvasLayer

onready var parent = get_parent()

func _on_Build_pressed():
	parent.SelectGrid("empty")
	
func _on_Upgrade_pressed():
	parent.SelectGrid("gartlin")
