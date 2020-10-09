extends CanvasLayer

func Refresh(btl:CharaBtl):
	$Hands/deck/deckCount/Label.text = str(len(btl.deck))
	$Hands/discard/discardCount/Label.text = str(len(btl.discard))
