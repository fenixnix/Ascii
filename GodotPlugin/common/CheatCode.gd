extends LineEdit

func _ready():
	hide()
	connect("text_entered",self,"on_enter")

func _input(event):
	if event.is_action_pressed("cheat"):
		show()
		grab_focus()
		clear()
		get_tree().set_input_as_handled()
	if event.is_action_pressed("ui_cancel"):
		hide()

func on_enter(_tx):
	var pair = _tx.split(" ")
	match pair[0]:
		"win":GlbAct.BattleWin()
		"freemove":GlbDat.marks["free_move"] = true
		"heal":GlbDat.chara.Rest(1)
		"relax":GlbDat.chara.iprs = 0
		"supply":GlbDat.chara.res = GlbDat.chara.mres

	if len(pair)<=1:
		hide()
		return
	match pair[0]:
		"gold":GlbAct.GainGold(int(pair[1]))
		"eqp":
			var eqp = $RndEqp.GenEqp(int(pair[1]))
			print("gen eqp:",eqp)
			GlbDat.PutItem(eqp)
		"iprs":GlbDat.chara.iprs = int(pair[1])
		"freemove":
			match pair[1]:
				"on":GlbDat.marks["free_move"] = true
				"off":GlbDat.marks["free_move"] = false
				_:GlbDat.marks["free_move"] = false
	hide()
