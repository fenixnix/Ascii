extends Control

var data
var curIndex = 0

onready var list = $ScrollContainer/GridContainer
onready var cardPrefab = preload("res://ui/CardPanel.tscn")

signal select(card)

func _ready():
	Set(GlbDb.cardDict.values())

func Set(dat):
	data = dat
	Clear()
	$ItemList.clear()
	for card in data:
		$ItemList.add_item(card.name)
#		var c = cardPrefab.instance()
#		c.Set(card)
#		list.add_child(c)
	_on_ItemList_item_selected(0)

func Clear():
	for c in list.get_children():
		c.queue_free()

func _on_ItemList_item_selected(index):
	curIndex = index
	$CardPanel.Set(data[curIndex])

func _on_OK_pressed():
	emit_signal("select",data[curIndex])
	queue_free()

func _on_ItemList_multi_selected(index, selected):
	curIndex = index
	$CardPanel.Set(data[curIndex])
