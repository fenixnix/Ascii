extends Node

var chara
var battle

var map
var gold = 0
var cur_floor = 0

var potion_dat = {
	"drop_rate":.4,
	"common":.65,
	"uncommon":.25,
	"rare":.1
}

func RollPotionRarity():
	if rand_range(0,1)<potion_dat.drop_rate:
		var rarity = rand_range(0,1)
		if rarity>(1-potion_dat.rare):
			return "rare"
		if rarity>(1-potion_dat.rare-potion_dat.uncommon):
			return "uncommon"
		return "common"
	return null

func CurrentSiteOptions():
	return map[cur_floor]
