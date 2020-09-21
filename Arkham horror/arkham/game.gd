extends Control

var hpDmg = 0
var sanDmg = 0
var resource = 0
var actionCnt = 0

var deck = []
var handCard = []
var discard = []

func _ready():
	rand_seed(OS.get_ticks_msec())
	$CharaRT.Set(GlbDat.chara)
	for index in GlbDat.deck:
		deck.append(GlbDb.cardDb[index])
	deck.shuffle()
	$Status.Refresh(self)

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
	if len(deck)>0:
		handCard.append(deck.pop_front())
	refresh()

func refresh():
	$Status.Refresh(self)

func _on_Return_pressed():
	get_tree().change_scene("res://main.tscn")

func _on_RES_add_pressed():
	resource+=1
	refresh()

func _on_RES_rmv_pressed():
	resource-=1
	refresh()

func _on_HP_add_pressed():
	hpDmg+=1
	refresh()

func _on_HP_rmv_pressed():
	hpDmg-=1
	refresh()

func _on_SAN_add_pressed():
	sanDmg+=1
	refresh()

func _on_SAN_rmv_pressed():
	sanDmg-=1
	refresh()

func _on_encounter_pressed():
	var res = GlbDat.ect_deck.pop_front()
	$TextureRect.texture = GlbDb.CardImg(res.img)

func _on_shuffle_ect_pressed():
	GlbDat.ect_deck.shuffle()
