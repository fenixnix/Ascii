extends Panel

var rarity_dict = {
	"Starter":Color.gray,
	"Common":Color.green,
	"Uncommon":Color.azure,
	"Rare":Color.gold,
}

func Set(card):
	$Cost/Cost.text = str(card.get("cost",0))
	$Frame.self_modulate = rarity_dict[card.get("rarity","Starter")]
	$Frame/Name.text = card.name
	$Image.texture = GlbDb.CardImage(card.img)
	$Type/Label.text = card.type
	$Desc.text = PoolStringArray(card.desc).join("\n")

func Upgrade():
	#TODO
	pass
