
#Desc:For each Curse in your deck, start each combat with 1 additional Strength.
func OnBattleStart(chara:CharaBtl):
    var cursed = GlbAct.CardFilter(chara.deck,"Cursed")
    chara.ModAttr({"type":"str","val":len(cursed)})

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass
            