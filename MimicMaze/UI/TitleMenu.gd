extends Control

signal new_game(mode)

enum GameMode{classic,sandbox}

func _ready():
	pass
	$"Menu/New Game".grab_focus()
	#$Title.text = tr("title")

func _on_Exit_pressed():
	GlbAudio.PlayUISfx("res://Audio/UI/back_002.ogg")
	yield(GlbAudio.ui_sfx,"finished")
	get_tree().quit()

func _on_New_Game_pressed():
	GlbAudio.PlayUISfx("res://Audio/UI/confirmation_001.ogg")
	emit_signal("new_game",GameMode.classic)
	queue_free()

func _on_Sandbox_pressed():
	GlbAudio.PlayUISfx("res://Audio/UI/confirmation_001.ogg")
	emit_signal("new_game",GameMode.sandbox)
	queue_free()

func _on_Option_pressed():
	var ui = load("res://UI/GameConfigUI.tscn").instance()
	add_child(ui)
	ui.Open()
