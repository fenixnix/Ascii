
#Desc:Whenever you play a Power, heal 2 HP.
func OnBattleStart(chara:CharaBtl):
    chara.add_child(self)
    chara.connect("play",self,"on_play",[chara])
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass

func on_play(card,chara):
    if card.type == "Power":
        chara.Heal(2)
