extends Node

var chara_:CharaBtl

func OnBattleStart(chara:CharaBtl):
	chara.connect("play",self,"on_play")

func on_play(card):
	if card.type == "Power":
		chara_.Heal(2)
