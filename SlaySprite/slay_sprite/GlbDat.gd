extends Node

var selectChara

var chara
var battle

var map
var gold = 0
var cur_floor = 0

var marks = {}
# card ect 3 37 60
# card shop 9 37 54
# upgrade chance
# act1 0%
# act2 25%
# act3 50%
var card_dat = {
	"option_cnt":3,
	"common":.54,
	"uncommon":.37,
	"rare":.09
}

var potion_dat = {
	"drop_rate":.4,
	"common":.65,
	"uncommon":.25,
	"rare":.1
}

var relic_dat ={
	"elite_drop_cnt":1,
	"common":3,
	"uncommon":2,
	"rare":1
}

const chest_dat = {
	"common":{
		"rate":3,
		"gold":{"rate":.5,"base":25,"rnd":0.1},
		"relic":{"Common":3,"Uncommon":1}
	},
	"uncommon":{
		"rate":2,
		"gold":{"rate":.35,"base":50,"rnd":0.1},
		"relic":{"Common":35,"Uncommon":50,"Rare":15}
	},
	"rare":{
		"rate":1,
		"gold":{"rate":.5,"base":75,"rnd":0.1},
		"relic":{"Uncommon":3,"Rare":1}
	}
}

const shop_dat = {
	"rnd":{
		"color":.1,
		"gray":.1,
		"relic":.05,
		"potion":.05,
	},
	"color":{
		"Attack":2,
		"Skill":2,
		"Power":1,
		"Common":50,
		"Uncommon":75,
		"Rare":150,
		"OnSale":.5,
	},"gray":{
		"Uncommon":90,
		"Rare":180
	},"relic":{
		"Common":150,
		"Uncommon":250,
		"Rare":300,
		"Shop":150#Right 1 Allways Shop
	},
		"potion":{
			"Common":50,
			"Uncommon":75,
			"Rare":100
	},
	"remove":{"cost":75,"addtive":25,"cnt":0}
}

func RndPrice(type,rarity):
	var rndRate = shop_dat.rnd[type]
	var basePrice = shop_dat[type][rarity]
	var rndVal = rndRate*basePrice
	return basePrice + ceil(rand_range(-rndVal,rndVal))

func RollRarity(dat):
	var rarity = rand_range(0,1)
	if rarity>(1-dat.rare):
		return "rare"
	if rarity>(1-dat.rare-dat.uncommon):
		return "uncommon"
	return "common"

func RollCardRarity():
	return RollRarity(card_dat)

func RollChest(data=chest_dat):
	var result = {}
	var tmp = []
	for d in data:
		tmp.append(d.rate)
	var index = NixRnd.RandIndexByRate(tmp)
	result["rarity"] = data.keys()[index]
	var chest = data.values()[index]
	if rand_range(0,1)<=(1-chest.gold.rate):
		result["gold"] = NixRnd.RandInt(chest.gold.base,chest.gold.rnd)
	#TODO relic
	var rlc = []
	for r in chest.relic.values():
		rlc.append(rlc)
	var rlcIndex = NixRnd.RandIndexByRate(rlc)
	var relic_rarity = chest.relic.values()[rlcIndex]
	result["relic"] = RollRelic(chara.relic,relic_rarity)
	return result

func RollRelic(already_have_list,rarity):
	var tmp = []
	for r in GlbDb.relicDict.values():
		if !already_have_list.has(r.name)&&r.rarity == rarity:
			tmp.append(r)
	return tmp[randi()%len(tmp)]

func RollEliteRelic():
	return GlbDb.relicDict.values()[randi()%len(GlbDb.relicDict)]

func RollPotionRarity():
	if rand_range(0,1)<potion_dat.drop_rate:
		return RollRarity(potion_dat)
	return null

func CurrentSiteOptions():
	return map[cur_floor]
