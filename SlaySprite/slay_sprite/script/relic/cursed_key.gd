
#Desc:Gain 1 Energy at the start of each turn. Whenever you open a non-boss chest, obtain a Curse.
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    chara.en += 1
    GlbDat.marks["cursed_chest"]            