extends Panel

var data

signal select(card)

const class_dict = {
	"all":Color.gray,
	"ironclad":Color.red,
	"silence":Color.green,
	"defect":Color.blue,
	"watcher":Color.purple
}

const rarity_dict = {
	"Starter":Color.gray,
	"Common":Color.white,
	"Uncommon":Color.green,
	"Rare":Color.yellow,
	"Special":Color.purple
}

const type_dict = {
	"Attack":Color.coral,
	"Skill":Color.cornflower,
	"Power":Color.goldenrod,
	"Status":Color.gray,
	"Curse":Color.purple
}

func Set(card):
	data = card
	$Cost.visible = !card.desc.has("Unplayable")
	
	self_modulate = class_dict[card.get("class","all")]
	$Cost/Cost.text = str(card.get("cost",0))
	$Cost.self_modulate = rarity_dict[card.get("rarity","Starter")]
	$Frame.self_modulate = rarity_dict[card.get("rarity","Starter")]
	$Frame/Name.text = card.name
	$Image.texture = GlbDb.CardImage(card.img)
	$Type.self_modulate = type_dict[card.get("type","Attack")]
	$Type/Label.text = card.type
	#$Desc.text = PoolStringArray(card.desc).join("\n")
	$Panel/Desc.Set(card.desc)

func Upgrade():
	#TODO
	pass
	
func _on_CardPanel_gui_input(event):
	if event.is_action_pressed("click"):
		emit_signal("select",data)
