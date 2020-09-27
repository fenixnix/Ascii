extends Node

class_name CharaBtl

var chara

var deck = []
var discard = []

func Set(_chara):
	chara = _chara
	deck.clear()
	discard.clear()
	for card in chara.cards.keys():
		for i in chara.cards[card]:
			deck.append(GlbDb.cardDict[card])
	deck.shuffle()
