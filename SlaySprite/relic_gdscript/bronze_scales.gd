
#Desc:Whenever you take damage, deal 3 damage back.
func OnBattleStart(chara:CharaBtl):
    chara.ModPower({"type":"thorn","val":3})

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass
            