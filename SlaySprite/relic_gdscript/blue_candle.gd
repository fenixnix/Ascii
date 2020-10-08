
#Desc:Curse cards can now be played. Playing a Curse will make you lose 1 HP and Exhausts the card.
func OnBattleStart(chara:CharaBtl):
    for card in chara.deck:
        if card.type == "Cursed":
            card.desc.erase("Unplayable")
            card.desc.append("Exhausts")
            card.desc.append("type":"costHp","val":1)

func OnBattleEnd(chara:CharaBtl):
    pass

func OnEnterSite(chara,site):
    pass

func OnPickUp(chara):
    pass
            