extends Node

func run(src,card,dst,para):
	for c in src.hand:
		if c.type!="Attack":
			src.Exhaust(c)
