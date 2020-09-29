extends Control

export(NodePath) var deck_position_node

var card_init_position

var hands = []

onready var card_prefab = preload("res://Card.tscn")

func _ready():
	card_init_position = get_node(deck_position_node).position

func Draw(card):
	var Card = card_prefab.instance()
	add_child(Card)
	Card.Set(card)
	hands.append(Card)
	Card.rect_position = card_init_position
	PositionAnim()

func Discard(card):
	for c in hands:
		if c.data == card:
			hands.erase(c)
			c.queue_free()
			break
	PositionAnim()

func Exhaust(card):
	for c in hands:
		if c.data == card:
			hands.erase(c)
			c.queue_free()
			break
	PositionAnim()

func PositionAnim():
	var x_start_position = len(hands)*50/2
	var offset = x_start_position
	for card in hands:
		card.AnimMove(Vector2(offset,0))
		offset -= 50
