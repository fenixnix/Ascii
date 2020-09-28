extends Node

class_name Chara

var mhp = 100
var hp = 100
var en = 3

var cards = []
var relic = []
var class_ = ""

func Set(dat):
	mhp = dat.hp
	hp = mhp
	class_ = dat["class"]
	cards.clear()
	for card in dat.cards.keys():
		for i in dat.cards[card]:
			cards.append(GlbDb.cardDict[card])
