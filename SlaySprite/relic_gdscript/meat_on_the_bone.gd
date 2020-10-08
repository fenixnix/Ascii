
#Desc:If your HP is at or below 50% at the end of combat, heal 12 HP.
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    if chara.hp<chara.mhp/2:
        chara.Heal(12)
        
func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass
            