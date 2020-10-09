extends Node

func run(src,card,dst,para):
	src.Exhaust(src.hand[randi()%len(src.hand)])
