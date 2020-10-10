
#Desc:Whenever you enter a shop room, heal 15 HP.
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    if site.type == "shop":
        chara.Heal(15)

func OnPickUp(chara):
    pass
            