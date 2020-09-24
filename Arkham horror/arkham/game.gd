extends Node

var curAgenda = 0
var curAct = 0
var clue = 0

onready var msg_lab = $UI/msg/Message

func _ready():
	seed(OS.get_ticks_msec())
	#$UI/CharaStatus.Set(GlbDat.charaList)
	for c in GlbDat.charas.get_children():
		c.Draw(5)
	
	var agenda = GlbDat.story.agenda[curAgenda]
	var act = GlbDat.story.act[curAct]
	
	msg_lab.Title(agenda.name)
	msg_lab.Text(agenda.desc)
	msg_lab.Title(act.name)
	msg_lab.Text(act.desc)
	
	GlbDat.doom = agenda.doom
	clue = act.clues
	
	$UI/StoryMark.bbcode_enabled = true
	$UI/StoryMark.bbcode_text = "[img=32x32]res://image/doom.png[/img] %d [img=32x32]res://image/clue.png[/img] %d"%[GlbDat.doom,clue]

	$map.SetLocation(GlbDat.story.locations)
	for chara in GlbDat.charas.get_children():
		$map.Enter(chara,GlbDat.story.start_location)
	
	if GlbDat.charas.get_child_count()>0:
		_on_CharaList_select(GlbDat.charas.get_child(0))

func PushAct():
	var act = GlbDat.story.act[curAct]
	msg_lab.Title(act.nameB)
	msg_lab.Text(act.descB)
	$map.SetLocation(act.get("locations",[]))
	if act.has("start_location"):
		for chara in GlbDat.charas.get_children():
			$map.Enter(chara,act.start_location)
	curAct+=1
	msg_lab.Title(GlbDat.story.act[curAct].nameB)
	msg_lab.Text(GlbDat.story.act[curAct].descB)
	$map.Refresh()

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
	$map.SetupAction(chara)

func refresh_chara(chara):
	$UI/CharaList.Init(GlbDat.charas)
	$UI/AT.Set(chara)
	$UI/HandCards.Set(chara.hands)
	$UI/Assets.Set(chara.assets)
	$UI/Threats.Set(chara.threats)
	#threat

func _on_HandCards_use(card):
	var res = GlbDat.Use(card)
	if res:
		$AnimEfx.UseCardEfx(card)
		refresh_chara(GlbDat.current_chara)

func _on_DrawCard_pressed():
	GlbDat.ActionDrawCard()
	refresh_chara(GlbDat.current_chara)

func _on_SupplyResource_pressed():
	GlbDat.ActionSupply()
	refresh_chara(GlbDat.current_chara)

func _on_EndTurn_pressed():
	GlbDat.EnemyPhyse()
	GlbDat.SupplyPhase()
	GlbDat.MythosPhase()
	refresh_chara(GlbDat.current_chara)
	$map.Refresh()
