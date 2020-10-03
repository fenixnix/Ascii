extends Node

func run(src,card,dst,para):
	#para.type
	var statusCard = GlbDb.statusCardDict[para.get("type")].duplicate(true)
	src.PutIntoDiscard(statusCard)
