extends Control

signal finish()

var cnts ={
	"card":5,
	"gray_card":2,
	"relic":3,
	"potion":3,
	"rmv_card":1
}

func _ready():
	for c in $CardList.get_children():
		c.queue_free()
	RndInit()

func RndInit():
	var cards = GlbDb.RndSelCard(cnts.card)
	var on_sale_index = randi()%cnts.card
	var index:int = 0
	for c in cards:
		add_card(c,on_sale_index == index)
		index += 1
	var gray_cards = GlbDb.RndSelCard(cnts.gray_card)
	for c in gray_cards:
		add_card(c)

onready var card_prefab = preload("res://ui/ShopCardSlot.tscn")
func add_card(c,on_sale = false):
	print(on_sale)
	var card  = card_prefab.instance()
	var price = rnd_card_price(c)
	if on_sale:
		price = ceil(price/2)
	price *= ceil(1.0-GlbDat.marks.get("discount",0))
	$CardList.add_child(card)
	card.Set(c,{"good":c,"price":price,"on_sale":on_sale})

func rnd_card_price(card):
	var price:int = 0
	match card.rarity:
		"Starter","Common":price = 50
		"Uncommon":price = 75
		"Rare":price = 150
	return price + randi()%10-5

func _on_Leave_pressed():
	emit_signal("finish")
	queue_free()

func _on_RemoveCard_pressed():
	GlbAct.RemoveCard()
