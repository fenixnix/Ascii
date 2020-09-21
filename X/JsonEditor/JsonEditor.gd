extends Control

var data = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Add_Elem_pressed():
	data.append({})
	refresh()

func refresh():
	$ScriptEdit.text = ""
	for l in data:
		$ScriptEdit.text += str(l) + "\n"
