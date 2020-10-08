
#Desc:Whenever you climb a floor, gain 12 Gold. No longer works when you spend any Gold at the shop.#TODO
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    chara.GainGold(12)

func OnPickUp(chara):
    pass
            