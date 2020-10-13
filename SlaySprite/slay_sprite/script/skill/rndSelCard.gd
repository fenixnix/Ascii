extends Node

func run(src:CharaBtl,card,dst,para):
	var lst = GlbDb.cardDict.values()
	if para.has("type"):
		lst = GlbDb.Filter(lst,"type",para.type)
	if para.has("class"):
		lst = GlbDb.Filter(lst,"class",para["class"])
	lst.shuffle()
