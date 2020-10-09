extends Node

func run(src:CharaBtl,card,dst,para):
	for d in card.desc:
		if d.type == "dmg":
			d.val += para.dmg
