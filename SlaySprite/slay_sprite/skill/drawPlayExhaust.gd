extends Node

func run(src,card,dst,para):
	var c = src.Draw()
	src.PlayCard(c)
	src.Exhaust(c)
