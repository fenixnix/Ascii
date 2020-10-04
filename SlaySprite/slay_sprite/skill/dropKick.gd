extends Node

func run(src:CharaBtl,card,dst,para):
	if dst.status.has("val"):
		src.en +=1
		src.Draw()
