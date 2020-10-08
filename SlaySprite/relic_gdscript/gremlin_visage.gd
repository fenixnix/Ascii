
#Desc:Start each combat with 1 Weak.
func OnBattleStart(chara:CharaBtl):
    for e in GlbDat.BattleGround().get_children():
        e.ModStatus({"type":"weak","val":1})
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass
            