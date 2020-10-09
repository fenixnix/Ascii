extends Node

func run(src:CharaBtl,card,dst,para):
	if src.attr.has("str"):
		src.attr["str"] *=2
