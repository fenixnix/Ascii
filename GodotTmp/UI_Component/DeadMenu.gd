extends Control

onready var lst = $PanelContainer/VBoxContainer

func _ready():
	lst.Init(["Retry","BackToMain","Exit"])
