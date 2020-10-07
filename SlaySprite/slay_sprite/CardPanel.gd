extends Panel

const rarity_dict = {
	"Starter":Color.gray,
	"Common":Color.green,
	"Uncommon":Color.aqua,
	"Rare":Color.gold,
}

const type_dict = {
	"Attack":Color.coral,
	"Skill":Color.cornflower,
	"Power":Color.goldenrod,
	"Status":Color.gray,
	"Curse":Color.purple
}

func Set(card):
	$Cost/Cost.text = str(card.get("cost",0))
	$Cost.self_modulate = rarity_dict[card.get("rarity","Starter")]
	$Frame.self_modulate = rarity_dict[card.get("rarity","Starter")]
	$Frame/Name.text = card.name
	$Image.texture = GlbDb.CardImage(card.img)
	$Type.self_modulate = type_dict[card.get("type","Attack")]
	$Type/Label.text = card.type
	#$Desc.text = PoolStringArray(card.desc).join("\n")
	$Desc.Set(card.desc)

func Upgrade():
	#TODO
	pass
