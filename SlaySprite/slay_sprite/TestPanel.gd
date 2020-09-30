extends VBoxContainer

func _on_TestDraw_pressed():
	get_node("../../").DrawCard()

func _on_TestWin_pressed():
	GlbAct.BattleWin()
