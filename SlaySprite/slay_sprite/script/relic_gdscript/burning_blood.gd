#Desc:Gain 1 Energy at the start of each turn. On Card Reward screens, you have 2 fewer cards to choose from
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    chara.Heal(6)

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass