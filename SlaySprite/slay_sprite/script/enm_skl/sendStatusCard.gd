extends Node

func run(btl:Enemy,target:CharaBtl,para):
	var statusCard = GlbDb.statusCardDict[para.get("type")]
	for i in para.get("val",1):
		target.PutIntoDiscard(statusCard.duplicate(true))
