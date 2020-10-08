
#Desc:At the start of each combat, gain 1 Dexterity.
func OnBattleStart(chara:CharaBtl):
    chara.ModAttr({"type":"dex","val":1})
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass
            