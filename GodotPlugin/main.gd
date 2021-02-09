extends Node

func _ready():
	$NixStoryPlayer.Play()

func _on_setting_pressed():
	GlbUI.Push("res://addons/NixGUI/SystemMenu.tscn")
