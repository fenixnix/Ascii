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
	for c in cards:
		add_card(c)
	var gray_cards = GlbDb.RndSelCard(cnts.gray_card)
	for c in gray_cards:
		add_card(c)

onready var card_prefab = preload("res://Card.tscn")
onready var price_label_prefab = preload("res://ui/PriceLabel.tscn")
func add_card(c):
	var card  = card_prefab.instance()
	$CardList.add_child(card)
	card.Set(c)
	var pLabel = price_label_prefab.instance()
	card.add_child(pLabel)
	pLabel.Set({"good":c,"price":rnd_card_price(c)})

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
