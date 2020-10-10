
#Desc:If you do not play any Attacks during your turn, gain an extra Energy next turn.
var atk_mrk = false
func OnBattleStart(chara:CharaBtl):
    atk_mrk = false
    chara.add_child(self)
    chara.connect("play",self,"on_play")
    pass

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass
            
func on_play(card):
    if card.type == "Attack":
        atk_mrk = true

func on_turn_start():
    if !atk_mrk:
        atk_mrk = true
        chara.en += 1