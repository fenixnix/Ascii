
#Desc:Gain 1 Energy at the start of each turn. You can no longer gain Gold.
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    chara.en += 1
    GlbDat.marks["no_gain_gold"] = true            