
#Desc:Raise your Max HP by 10.
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    chara.mhp += 10
    chara.hp += 10
    pass
            