extends Node

signal select_card(card)
signal select_site(site)

func LoadUI(name):
	var ui = load("res://ui/%s.tscn"%name).instance()
	add_child(ui)
	return ui

func CardReward():
	var ui = LoadUI("RewardCards")
	ui.Reward()

func CardView():
	OpenView(GlbDat.chara.cards)

func SelectCard(list):
	pass

func OpenView(list):
	var ui = LoadUI("CardView")
	add_child(ui)
	ui.Set(list)

func SelectSite(list):
	var ui = LoadUI("SiteSelection")
	ui.Set(list)
	var site = yield(ui,"select")
	emit_signal("select_site",site)

func _on_DbView_pressed():
	OpenView(GlbDb.cardDict.values())

func _on_NextSite_pressed():
	GlbAct.NextSite()

func _on_Forge_pressed():
	GlbAct.Forge()

func _on_RelicView_pressed():
	var ui = LoadUI("RelicView")
	add_child(ui)
	ui.Set(GlbDb.relicDict.values())
