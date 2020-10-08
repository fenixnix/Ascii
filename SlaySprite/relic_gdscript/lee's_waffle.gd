
#Desc:Raise your Max HP by 7 and heal all of your HP.
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    chara.mhp += 7
    chara.Heal(1)            