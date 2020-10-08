
#Desc:Upon pick up, choose an Attack card. At the start of each combat, this card will be in your hand.
var card

func OnBattleStart(chara:CharaBtl):
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    var selcard = GlbUi.SelectCard(GlbAct.CardFilter(chara.card,"Attack"))
    sel.desc.append("Start in Hand")
            