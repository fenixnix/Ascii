extends Node

onready var view_prefab = preload("res://ui/CardView.tscn")

signal select_card(card)

func CardReward():
	var ui = load("res://ui/RewardCards.tscn").instance()
	add_child(ui)
	ui.Reward()

func CardView():
	OpenView(GlbDat.chara.cards)

func SelectCard(list):
	pass

func _on_DbView_pressed():
	OpenView(GlbDb.cardDb)

func OpenView(list):
	var ui = view_prefab.instance()
	add_child(ui)
	ui.Set(list)
