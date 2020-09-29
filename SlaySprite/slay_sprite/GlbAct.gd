extends Node

func GetChara():
	return get_tree().current_scene.get_node("battle").plrBtl

func PlayCard(card,target = null):
	GetChara().PlayCard(card,target)
