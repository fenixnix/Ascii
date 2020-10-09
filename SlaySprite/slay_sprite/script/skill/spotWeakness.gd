extends Node

func run(src:CharaBtl,card,dst,para):
	if dst.AttemptAtk():
		src.ModAttr(para)
