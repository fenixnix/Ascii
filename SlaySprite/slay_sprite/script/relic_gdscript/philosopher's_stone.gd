
#Desc:Gain 1 Energy at the start of each turn. ALL enemies start with 1 Strength.
func OnBattleStart(chara:CharaBtl):
    for enm in GlbDat.BattleGround().get_children():
        enm.ModAttr({"type":"str","val":1})

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    chara.en += 1
    pass
            