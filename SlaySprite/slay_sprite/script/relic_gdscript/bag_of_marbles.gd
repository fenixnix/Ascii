
#Desc:At the start of each combat, apply 1 Vulnerable to ALL enemies.
func OnBattleStart(chara:CharaBtl):
    for enm in GlbAct.BattleGround().get_children():
        enm.ModStatus({"type":"vul","val":1})

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass
            