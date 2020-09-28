extends Node

var plrBtl

func Start(dat):
	print(dat)
	plrBtl = CharaBtl.new()
	plrBtl.Set(dat.chara)
	DrawCard(5)
	refresh()

func refresh():
	print(plrBtl.deck)
	$UI/deckCount.text = str(len(plrBtl.deck))
	$UI/discardCount.text = str(len(plrBtl.discard))
	$Player.Set(plrBtl)

func DrawCard(cnt = 1):
	for i in cnt:
		var card = plrBtl.Draw()
		if card!=null:
			$UI/Hands.Draw(card)

func _on_TestDraw_pressed():
	DrawCard()
