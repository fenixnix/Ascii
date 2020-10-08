
#Desc:Prevent the first time you would lose HP in combat.
func OnBattleStart(chara:CharaBtl):
    chara.ModPower({"type":"fossil","val":1})

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass
            