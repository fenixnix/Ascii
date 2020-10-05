extends CanvasLayer

func Refresh(btl:CharaBtl):
	$Hands/deck/countCircle/deckCount.text = str(len(btl.deck))
	$Hands/discard/countCircle/discardCount.text = str(len(btl.discard))
