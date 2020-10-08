extends Node

var chara
var battle

var map
var gold = 0
var cur_floor = 0

var marks = {}

var card_dat = {
	"option_cnt":3
}

var potion_dat = {
	"drop_rate":.4,
	"common":.65,
	"uncommon":.25,
	"rare":.1
}

var relic_dat ={
	"elite_drop_cnt":1
}

var shop_dat = {
	"color":{
		"Attack":2,
		"Skill":2,
		"Power":1,
		"Common":"45~55",
		"Uncommon":"68~82",
		"Rare":"135~165",
		"OnSale":.5,
	},"gray":{
		"Uncommon":"81~99",
		"Rare":"162~198"
	},"relic":{
		"Common":"143~157",
		"Uncommon":"238~262",
		"Rare":"285~315",
		"Shop":"143~157"#Right 1 Allways Shop
	},"remove":{"cost":75,"addtive":25,"cnt":0}
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
