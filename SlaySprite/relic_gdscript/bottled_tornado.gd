
#Desc:Upon pick up, choose a Power card. At the start of each combat, this card will be in your hand.
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    var selcard = GlbUi.SelectCard(GlbAct.CardFilter(chara.card,"Power"))
    sel.desc.append("Start in Hand")
    pass
            