extends Control

func _on_Warrior_pressed():
	GlbDat.selectChara = "warrior"
	$BG.texture = load("res://image/ironcladPortrait.jpg")

func _on_Rogue_pressed():
	GlbDat.selectChara = "rogue"
	$BG.texture = load("res://image/silentPortrait.jpg")	

func _on_Embark_pressed():
	get_tree().change_scene("res://game.tscn")
