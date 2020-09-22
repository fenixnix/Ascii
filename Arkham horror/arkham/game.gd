extends Control

var curAgenda = 0
var curAct = 0
var doom = 0
var clue = 0

func _ready():
	rand_seed(OS.get_ticks_msec())
	$CharaStatus.Set(GlbDat.charaList)
	#$Status.Refresh(self)
	
	var agenda = GlbDat.story.agenda[curAgenda]
	var act = GlbDat.story.act[curAct]
	
	$msg/Message.Title(agenda.name)
	$msg/Message.Text(agenda.desc)
	$msg/Message.Title(act.name)
	$msg/Message.Text(act.desc)
	
	doom = agenda.doom
	clue = act.clues
	
	$StoryMark.bbcode_enabled = true
	$StoryMark.bbcode_text = "[img=32x32]res://image/doom.png[/img] %d [img=32x32]res://image/clue.png[/img] %d"%[doom,clue]

func PushAct():
	$msg/Message.Title(GlbDat.story.act[curAct].nameB)
	$msg/Message.Text(GlbDat.story.act[curAct].descB)
	curAct+=1
	$msg/Message.Title(GlbDat.story.act[curAct].nameB)
	$msg/Message.Text(GlbDat.story.act[curAct].descB)

func PushAgenda():	
	$msg/Message.Title(GlbDat.story.agenda[curAgenda].nameB)
	$msg/Message.Text(GlbDat.story.agenda[curAgenda].descB)
	curAgenda+=1
	$msg/Message.Title(GlbDat.story.agenda[curAgenda].nameB)
	$msg/Message.Text(GlbDat.story.agenda[curAgenda].descB)

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
