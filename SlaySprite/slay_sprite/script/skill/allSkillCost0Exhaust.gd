extends Node

func run(src:CharaBtl,card,dst,para):
	for c in src.AllCardInBattle():
		cost0Exhaust(c)

func cost0Exhaust(card):
	if card.type == "Skill":
		if typeof(card.cost) != typeof("X"):
			card.cost = 0
		card.desc.append("Exhaust")
