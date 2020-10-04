extends Node

func run(src,card,dst,para):
	var statusCard = GlbDb.statusCardDict[para.get("type")]
	for i in para.get("val",1):
		src.PutIntoDrawPile(statusCard.duplicate(true))
