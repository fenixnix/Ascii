extends Node

var story
var ect_deck = []
var chaosbag = []

var current_chara
var charas

func _init():
	charas = Node.new()
	charas.name = "charas"
	add_child(charas)

func InitGame(_charaList,deckList):
	for c in charas.get_children():
		c.queue_free()
	for i in len(_charaList):
		var cha = Chara.new()
		cha.Set(_charaList[i],deckList[i])
		$charas.add_child(cha)
	current_chara = $charas.get_child(0)
