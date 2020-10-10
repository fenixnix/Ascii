
#Desc:Your first attack each combat deals 8 additional damage.
func OnBattleStart(chara:CharaBtl):
    chara.ModPower({"type":"dmg+","val":8})
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass
            