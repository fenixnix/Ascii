
#Desc:At the start of each combat, gain 1 Artifact.
func OnBattleStart(chara:CharaBtl):
    chara.ModPower("type":"artifact","val":1)
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass
            