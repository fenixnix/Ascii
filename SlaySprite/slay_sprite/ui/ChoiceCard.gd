extends Control

onready var card_prefab = preload("res://ui/CardPanel.tscn")

var data

signal select(card)

func _ready():
	Set(GlbDb.cardDict.values().slice(0,2))

func Set(list):
	data = list
	for c in data:
		var card = card_prefab.instance()
		$Cards.add_child(card)
		card.Set(c)
		card.connect("select",self,"on_select")

func on_select(card):
	emit_signal("select",card)

func _on_Skip_pressed():
	emit_signal("select",null)
