extends Control

var life_time = 3

func _ready():
	$Tween.interpolate_property(self,"modulate",Color.white,Color(1,1,1,0),life_time,
	Tween.TRANS_BACK,Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	queue_free()

func Set(msg):
	$PanelContainer/RichTextLabel.bbcode_text = msg
