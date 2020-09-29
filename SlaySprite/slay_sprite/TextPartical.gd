extends Node2D

onready var prefab = preload("res://TPartical.tscn")

func Play(txt):
	var text = prefab.instance()
	text.text = txt
	add_child(text)
