
#Desc:Enemies drop 25% more Gold.
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    GlbDat.marks["gold_bonus"] += .25
            