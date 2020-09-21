extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	GlbGUI.Load("res://Sys/TestWin1.tscn")

func _on_Button2_pressed():
	GlbGUI.Load("res://Sys/TestWin2.tscn")

func _on_Button3_pressed():
	var img = get_viewport().get_texture().get_data()
	img.flip_y();
	img.save_png("screenshot.png")
