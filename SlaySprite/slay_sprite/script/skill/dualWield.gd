extends Node

func run(src:CharaBtl,card,dst,para):
	var tmp = []
	for c in src.hand:
		if tmp.type == "Attack"||tmp.type == "Power":
			tmp.append(c)
	GlbUi.SelectCard(tmp)
	var c = yield(GlbUi,"select_card")
	for i in para.val:
		src.Invoke(c.duplicate(true))
