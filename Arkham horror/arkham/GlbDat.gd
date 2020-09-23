extends Node

var story
var ect_deck = []
var chaosbag = []

#var chara = {}
#var deck = []

var charaList = []

func InitGame(_charaList,deckList):
	for i in len(_charaList):
		var cha = _charaList[i].duplicate(true)
		cha.hp = cha.STA
		cha.san = cha.SAN
		cha.clue = 0
		cha.res = 5
		cha.at = 3
		cha.deck = deckList[i].duplicate(true)
		cha.hand = []
		cha.discard = []
		charaList.append(cha)
