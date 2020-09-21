extends Control

var chara

func _ready():
	$ItemList.clear()
	for c in GlbDb.charaDb:
		$ItemList.add_item("#%s: %s"%[c.id,c.name])
		$ItemList.set_item_custom_fg_color($ItemList.get_item_count()-1,GlbDb.class_color[c["class"]])
	_on_ItemList_item_selected(0)
	for s in GlbDb.ectDb.keys():
		$story/story.add_item(s)
	_on_Level_item_selected(0)

func _on_ItemList_item_selected(index):
	GlbDat.chara = GlbDb.charaDb[index]
	#$HBox/CharaRT.Set(GlbDb.charaDb[index])
	$HBox/img/front.texture = GlbDb.CardImg(GlbDb.charaDb[index].get("img",""))
	$HBox/img/back.texture = GlbDb.CardImg(GlbDb.charaDb[index].get("imgb",""))

func _on_Level_item_selected(id):
	var levels = FileRW.LoadJsonFile("res://data/level.json")
	GlbDat.chaosbag = levels[levels.keys()[id]].dice

func _on_CardSet_pressed():
	var ui = load("CardSet.tscn").instance()
	add_child(ui)

func _on_EncounterSet_pressed():
	var ui = load("SetConfig.tscn").instance()
	add_child(ui)
	ui.connect("select",self,"on_select_ect_set")

func on_select_ect_set(set):
	GlbDat.ect_deck = set.duplicate(true)

func _on_Start_pressed():
	get_tree().change_scene_to(load("res://game.tscn"))

func _on_Scenario_pressed():
	var ui = load("Scenario.tscn").instance()
	add_child(ui)

func _on_ItemList_item_activated(index):
	$HBox/CharaList.add_item(GlbDb.charaDb[index].name,GlbDb.CardImg(GlbDb.charaDb[index].img))
