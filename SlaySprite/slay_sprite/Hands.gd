extends Control

export(NodePath) var deck_position_node
export(NodePath) var discard_position_node

var card_init_position
var card_discard_position

var hands = []

onready var card_prefab = preload("res://Card.tscn")

func _ready():
	card_init_position = get_node(deck_position_node).position
	card_discard_position = get_node(discard_position_node).position

func Draw(card):
	var Card = card_prefab.instance()
	add_child(Card)
	Card.is_thumbnail = true
	Card.Set(card)
	hands.append(Card)
	Card.rect_position = card_init_position
	PositionAnim()

func Refresh():
	for h in hands:
		h.Refresh()

func Invoke(card):
	var Card = card_prefab.instance()
	add_child(Card)
	Card.Set(card)
	PositionAnim()

func Discard(card):
	var Card
	for c in hands:
		if c.data == card:
			Card = c
			Card.AnimMove(card_discard_position)
			Card.Discard()
			hands.erase(c)
			break
	PositionAnim()

func Exhaust(card):
	for c in hands:
		if c.data == card:
			hands.erase(c)
			c.Exhaust()
			break
	PositionAnim()

const hand_card_offset = 80
func PositionAnim():
	var x_start_position = len(hands)*hand_card_offset/2
	var offset = x_start_position
	for card in hands:
		card.AnimMove(Vector2(offset,0))
		offset -= hand_card_offset
