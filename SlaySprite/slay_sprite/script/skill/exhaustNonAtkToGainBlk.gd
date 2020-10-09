extends Node

func run(src:CharaBtl,card,dst,para):
	var cnt = 0
	for card in src.hand:
		src.Exhaust(card)
		cnt += 1
	src.GainBlock(cnt*para.get("blk",5))
