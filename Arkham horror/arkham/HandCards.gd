extends HBoxContainer

onready var card_prefab = preload("res://Card.tscn")

func Set(hand_cards):
	for c in get_children():
		c.queue_free()
	for c in hand_cards:
		var card = card_prefab.instance()
		add_child(card)
		card.Set(c)
