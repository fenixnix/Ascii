extends Control

var validList = []
var dbDict = {}
var current_deck = {}

signal send_data(deck)

func Set(chara):
	print(chara)
	var filter = []
	for d in chara.deck.keys():
		match d:
			"Gd":filter.append("Guardian")
			"Sk":filter.append("Seeker")
			"Rg":filter.append("Rogue")
			"Ms":filter.append("Mystic")
			"Sv":filter.append("Survivor")
			"Nt":filter.append("Neutral")
	validList.clear()
	dbDict.clear()
	for c in GlbDb.cardDb:
		if filter.has(c["class"]):
			validList.append(c)
			dbDict[str(c.id)] = c
	$HBox/DB.clear()
	for v in validList:
		$HBox/DB.add_item("#%s:%s"%[v.id,v.name])
		if GlbDb.class_color.has(v["class"]):
			$HBox/DB.set_item_custom_fg_color($HBox/DB.get_item_count()-1, Color(GlbDb.class_color[v["class"]]))
	refresh_set()

func _on_DB_item_activated(index):
	add(str(validList[index].id))
	refresh_set()

func refresh_set():
	$HBox/VBox/Deck.clear()
	for k in current_deck.keys():
		$HBox/VBox/Deck.add_item("#%s:%s [*%d]"%[k,dbDict[k].name,current_deck[k]])

func _on_List_item_activated(index):
	rmv(index)
	refresh_set()

func add(id:String):
	if current_deck.has(id):
		current_deck[id] += 1
	else:
		current_deck[id] = 1

func rmv(index):
	var key = current_deck.keys()[index]
	current_deck[key]-=1
	if current_deck[key] <= 0:
		current_deck.erase(key)

func _on_Deck_item_selected(index):
	var key = current_deck.keys()[index]
	$HBox/CardRT.Set(dbDict[key])

func _on_DB_item_selected(index):
	$HBox/CardRT.Set(validList[index])

func _on_OK_pressed():
	emit_signal("send_data",current_deck)
	queue_free()
