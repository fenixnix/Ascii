extends Node

class_name Chara

var mhp:int = 100
var hp:int = 100
var en:int = 3

var cards = []
var relic = []
var potionSlots = [{"potion":null},{"potion":null},{"potion":null}]
var class_ = ""

signal gain_card(card)
signal gain_gold(gold)
signal rest()
signal heal(val)

func Set(dat):
	mhp = dat.hp
	hp = mhp
	class_ = dat["class"]
	cards.clear()
	GlbDat.gold = dat['$']
	for card in dat.cards.keys():
		for i in dat.cards[card]:
			cards.append(GlbDb.cardDict[card].duplicate(true))

func GainCard(card):
	if card.type == "Cursed":
		if GlbDat.marks.get("negate_curse",0)>0:
			GlbDat.marks["negate_curse"] -= 1
			return
	cards.append(card)
	emit_signal("gain_card",card)

func GainGold(gold):
	GlbDat.gold += gold
	emit_signal("gain_gold",gold)

func Rest(rate = .3):
	hp += mhp*rate
	if hp>mhp:
		hp = mhp
	emit_signal("rest")

func Heal(val):
	if GlbDat.has("no_heal"):
		return
	hp += val
	if hp > mhp:
		hp = mhp
	emit_signal("heal",val)
