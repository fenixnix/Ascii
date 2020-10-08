
#Desc:Upon pickup, choose and Transform 3 cards, then Upgrade them.
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    var cards = GlbAct.Transform(3)
    for card in cards:
        GlbAct.Upgrade(card)            