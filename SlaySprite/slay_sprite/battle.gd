extends Node

onready var plrBtl = $Player

func Start(dat):
	plrBtl.Set(dat.chara)
	DrawCard(5)
	refresh()

func refresh():
	print(plrBtl.deck)
	$UI/deckCount.text = str(len(plrBtl.deck))
	$UI/discardCount.text = str(len(plrBtl.discard))
	$Player.refresh()

func DrawCard(cnt = 1):
	for i in cnt:
		var card = plrBtl.Draw()

func _on_TestDraw_pressed():
	DrawCard()

func _on_EndTurn_pressed():
	$Player.EndTurn()
	$BattleGround.EnemyPhase()
	$Player.StartNewTurn()

func _on_Player_refresh_card():
	refresh()

func _on_Player_draw(card):
	$UI/Hands.Draw(card)
