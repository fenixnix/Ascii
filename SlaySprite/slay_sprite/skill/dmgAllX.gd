extends Node

func run(src,card,dst,para):
	var X = src.en + 0
	src.DuelDamage({"type":"dmg","val":para.val,"target":"all","times":X})
