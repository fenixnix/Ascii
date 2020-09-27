extends Panel

func Set(card):
	$Cost/Cost.text = str(card.get("cost",0))
	$Name.text = card.name
	$Image.texture = GlbDb.CardImage(card.img)
	$Type.text = card.type
	$Desc.text = PoolStringArray(card.desc).join("\n")
