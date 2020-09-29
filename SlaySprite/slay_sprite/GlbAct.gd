extends Node

func PlayCard(card,target = null):
	var plr = get_tree().current_scene.get_node("battle").plrBtl
	plr.PlayCard(card,target)
