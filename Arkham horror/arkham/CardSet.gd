extends Control

var data = []
var current_set
var set = []

onready var dbLst = $HBox/DB

func _ready():
	dbLst.clear()
	for card in GlbDb.cardDb:
		dbLst.add_item("#%s:%s"%[card.id,card.name])
		if GlbDb.class_color.has(card["class"]):
			dbLst.set_item_custom_fg_color(dbLst.get_item_count()-1, Color(GlbDb.class_color[card["class"]]))
	_on_Load_pressed()
	refresh_deck_list()
	refresh_deck()

func _on_DB_item_selected(index):
	$HBox/CardRT.Set(GlbDb.cardDb[index])

func _on_DB_item_activated(index):
	set.append(index)
	refresh_deck()

onready var deck = $HBox/VBox/Deck
func refresh_deck():
	deck.clear()
	for index in set:
		var card = GlbDb.cardDb[index]
		deck.add_item("#%s:%s"%[card.id,card.name])
		deck.set_item_custom_fg_color(deck.get_item_count()-1, Color(GlbDb.class_color[card["class"]]))
	$HBox/VBox/DeckCnt.text = "Count:%d"%len(set)

onready var deck_list = $HBox/VBox/DeckList
func refresh_deck_list():
	deck_list.clear()
	for l in data:
		deck_list.add_item("%s *%d"%[l.name,len(l.set)])

func _on_Deck_item_selected(index):
	var card = GlbDb.cardDb[set[index]]
	$HBox/CardRT.Set(card)

func _on_Deck_item_activated(index):
	set.remove(index)
	refresh_deck()

func _on_OK_pressed():
	GlbDat.deck = set
	queue_free()

func _on_Save_pressed():
	FileRW.SaveJsonFile("card_set.json",data)

func _on_Load_pressed():
	data = FileRW.LoadJsonFile("card_set.json")
	if data == null:
		data = []

func _on_Clear_pressed():
	set.clear()
	refresh_deck()

func _on_new_pressed():
	data.append({
		"name":$HBox/VBox/menu/LineEdit.text,
		"set":[]
	})
	set = data.back().set
	refresh_deck_list()
	refresh_deck()

func _on_del_pressed():
	data.erase(set)
	if len(data)>0:
		set = data[0].set
	else:
		set = []
	refresh_deck_list()
	refresh_deck()

func _on_DeckList_item_selected(index):
	current_set = data[index]
	set = current_set.set
	refresh_deck()

func _on_LineEdit_text_changed(new_text):
	current_set.name = new_text
	refresh_deck_list()
