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
var threats = []

var location

func Set(dat,_deck):
	data = dat
	hp = dat.STA
	san = dat.SAN
	for k in _deck.keys():
		for i in _deck[k]:
			deck.append(k)
	#deck.shuffle()

func GetAttr(key):
	return data.get(key,0)

func Draw(cnt = 1):
	for i in cnt:
		hands.append(deck.pop_front())

func EqpAsset(_asset):
	var asset = _asset.duplicate(true)
	asset.cd = false
	assets.append(asset)

func Encounter(card):
	print_debug(card)
	match card.type:
		"Enemy":
			var enm = location.Spawn(card.id)
			threats.append(enm)
		_:threats.append(card)

func Attack(enm,para):
	print("Attack",enm,para)
	var res = GlbDat.Roll(self,"C",enm.get("C",0),para.get("C",0))
	if res:
		enm.TakeDmg(1+para.get("dmg",0))
