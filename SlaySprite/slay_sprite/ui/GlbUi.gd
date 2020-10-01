extends Node

signal select_card(card)

func CardReward():
	var ui = load("res://ui/RewardCards.tscn").instance()
	add_child(ui)
	ui.Reward()

func CardView():
	var ui = load("res://ui/CardView.tscn").instance()
	add_child(ui)
	ui.Set(GlbDat.chara.cards)

func SelectCard(list):
	pass
