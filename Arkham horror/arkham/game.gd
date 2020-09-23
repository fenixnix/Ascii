extends Node

var curAgenda = 0
var curAct = 0
var doom = 0
var clue = 0

onready var msg_lab = $UI/msg/Message


func _ready():
	rand_seed(OS.get_ticks_msec())
	$UI/CharaStatus.Set(GlbDat.charaList)
	$UI/CharaList.Init(GlbDat.charaList)
	#$Status.Refresh(self)
	
	var agenda = GlbDat.story.agenda[curAgenda]
	var act = GlbDat.story.act[curAct]
	
	msg_lab.Title(agenda.name)
	msg_lab.Text(agenda.desc)
	msg_lab.Title(act.name)
	msg_lab.Text(act.desc)
	
	doom = agenda.doom
	clue = act.clues
	
	$UI/StoryMark.bbcode_enabled = true
	$UI/StoryMark.bbcode_text = "[img=32x32]res://image/doom.png[/img] %d [img=32x32]res://image/clue.png[/img] %d"%[doom,clue]

	#Location
	for l in GlbDat.story.locations:
		$map.AddLocation(l)
	for chara in GlbDat.charaList:
		$map.Enter(chara,GlbDat.story.start_location)

func PushAct():
	msg_lab.Title(GlbDat.story.act[curAct].nameB)
	msg_lab.Text(GlbDat.story.act[curAct].descB)
	curAct+=1
	msg_lab.Title(GlbDat.story.act[curAct].nameB)
	msg_lab.Text(GlbDat.story.act[curAct].descB)

func PushAgenda():	
	msg_lab.Title(GlbDat.story.agenda[curAgenda].nameB)
	msg_lab.Text(GlbDat.story.agenda[curAgenda].descB)
	curAgenda+=1
	msg_lab.Title(GlbDat.story.agenda[curAgenda].nameB)
	msg_lab.Text(GlbDat.story.agenda[curAgenda].descB)

func _on_roll_pressed():
	rand_seed(OS.get_ticks_msec())
	var res = GlbDat.chaosbag[randi()%len(GlbDat.chaosbag)]
	$roll_result.bbcode_enabled = true
	match res:
		"X","@","#","&","*":
			$roll_result.bbcode_text = "[font=res://font/icon.tres][center]%s[/center][/font]"%GlbDb.chaos_symbel[res]
		_:
			$roll_result.bbcode_text = "[center]%d[/center]"%res
#	#TestSymbel
#	for k in GlbDb.chaos_symbel.keys():
#		$roll_result.text += GlbDb.chaos_symbel[k]

func _on_shuffle_pressed():
	GlbDat.deck.shuffle()

func _on_draw_pressed():
#	if len(deck)>0:
#		handCard.append(deck.pop_front())
	refresh()

func refresh():
	$Status.Refresh(self)

func _on_Return_pressed():
	get_tree().change_scene("res://main.tscn")

func _on_encounter_pressed():
	var res = GlbDat.ect_deck.pop_front()
	$TextureRect.texture = GlbDb.CardImg(res.img)

func _on_shuffle_ect_pressed():
	GlbDat.ect_deck.shuffle()


func _on_Button_pressed():
	PushAct()

func _on_Push_Agenda_pressed():
	PushAgenda()

func _on_CharaList_select(chara):
	GlbDat.current_chara = chara
	refresh_chara(chara)

func refresh_chara(chara):
	$UI/HandCards.Set(chara.hands)
