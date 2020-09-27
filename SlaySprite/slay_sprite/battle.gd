extends Node

var plrBtl

func Start(dat):
	print(dat)
	plrBtl = CharaBtl.new()
	plrBtl.Set(dat.chara)
	refresh()

func refresh():
	$UI/deckCount.text = str(len(plrBtl.deck))
	$UI/discardCount.text = str(len(plrBtl.discard))
