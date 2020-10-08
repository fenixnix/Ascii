
#Desc:Upon pick up, choose a Skill card. At the start of each combat, this card will be in your hand.
func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    var selcard = GlbUi.SelectCard(GlbAct.CardFilter(GlbDat.chara.card,"Skill"))
    sel.desc.append("Start in Hand")
            