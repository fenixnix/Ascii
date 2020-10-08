
#Desc:Elites now drop 2 Relics when defeated.
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    GlbDat.relic_dat["elite_drop_cnt"] = 2
    pass
            