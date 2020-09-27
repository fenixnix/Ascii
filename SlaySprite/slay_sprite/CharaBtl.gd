extends Node

class_name CharaBtl

var chara

var deck = []
var hand = []
var discard = []

func Set(_chara):
	chara = _chara
	deck.clear()
	discard.clear()
	for card in chara.cards.keys():
		for i in chara.cards[card]:
			deck.append(GlbDb.cardDict[card])
	deck.shuffle()

func Draw():
	if len(deck)<=0:
		ReChargeDeck()
	if len(deck)>0:
		print_debug("Draw")
		var c= deck.pop_front()
		hand.push_back(c)
		return c
	return null

func ReChargeDeck():
	print_debug("Refesh Deck")
	for d in discard:
		deck.append(d)
	discard.clear()
	deck.shuffle()
