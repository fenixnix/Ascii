
#Desc:Upon pickup, obtain an additional copy of a card in your deck.
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    var selcard = GlbUi.SelectCard(chara.cards)
    chara.GainCard(selcard.duplicate(true))