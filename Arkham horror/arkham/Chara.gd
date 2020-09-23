extends Node

class_name Chara

var data

var hp = 0
var san = 0
var res = 5
var clue = 0

var at = 3

var deck = []
var hands = []
var discard = []

var assets = []

func Set(dat,_deck):
	data = dat
	hp = dat.STA
	san = dat.SAN
	for k in _deck.keys():
		for i in _deck[k]:
			deck.append(k)
	deck.shuffle()

func Draw(cnt = 1):
	for i in cnt:
		hands.append(deck.pop_front())
