extends Node

class_name Chara

var mhp:int = 100
var hp:int = 100
var en:int = 3

var cards = []
var relic = []
var class_ = ""

func Set(dat):
	mhp = dat.hp
	hp = mhp
	class_ = dat["class"]
	cards.clear()
	GlbDat.gold = dat['$']
	for card in dat.cards.keys():
		for i in dat.cards[card]:
			cards.append(GlbDb.cardDict[card])

func Rest():
	hp += mhp*.3
	if hp>mhp:
		hp = mhp
