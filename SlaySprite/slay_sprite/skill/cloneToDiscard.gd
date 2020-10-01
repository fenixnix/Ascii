extends Node

func run(src,card,dst,para):
	var clone = card.duplicate(true)
	src.Clone(clone)
	src.Discard(clone)
