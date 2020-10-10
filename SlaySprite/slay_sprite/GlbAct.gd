extends Node

#func _ready():
#	randomize()
#	GetSetEnmLst([
#					"louse_R|louse_G*2"
#				])

func GetChara():
	return GlbDat.battle.plrBtl

func RefreshMainMenu():
	get_node("/root/game/UI/MainMenu").Refresh()

func PlayCard(card,target = null):
	GetChara().PlayCard(card,target)

func RndGenAtkCard():
	#TODO
	return GlbDb.cardDict["Strike"].duplicate(true)

func Forge():
	var forge = GlbUi.LoadUI("Forge")
	forge.Set(GlbDat.chara.cards)
	yield(forge,"finish")

func RemoveCard(cnt = 1):
	var remove = GlbUi.LoadUI("RemoveCard")
	remove.Set(GlbDat.chara.cards)
	yield(remove,"finish")

func UpgradeCard(card):
	var dict = card.get("upgrade",{})
	if len(dict) == 0:
		return card
	card.name += "+"
	for k in dict.keys():
		match k:
			"dmg","blk","vul","weak","frail","draw","costHp","en":
				for d in card.desc:
					if d.type == k:
						d.val += dict[k]
			"dmg_times":
				for d in card.desc:
					if d.type == "dmg":
						d.times == dict[k]
			"cost":
				card.cost += dict[k]
			"replace_script":
				for d in card.desc:
					if d.type == "script":
						d.val = dict[k]
			"replace_script_para":
				for d in card.desc:
					if d.type == "script":
						for kk in d.val.keys():
							for pk in d.para.keys():
								if pk == kk:
									d.para[kk] += d.val[kk]
									#TODO
									print(dict[k])
	if !card.desc.has("InfUpgrade"):
		card.erase("upgrade")
	return card

func BattleGround():
	return GlbDat.battle

func BattleWin():
	BattleGround().Stop()
	print_debug("Battle Win!!!")
	var ui = GlbUi.LoadUI("Reward")
	ui.Set(BattleGround().result)
	yield(ui,"finish")

	RefreshMainMenu()
	NextSite()

func EnterSite():
	GlbUi.SelectSite(GlbDat.CurrentSiteOptions())
	var site = yield(GlbUi,"select_site")
	match site:
		"enm":Encounter('enm')
		"elite":Encounter('elite')
		"boss":Encounter('boss')
		"chest":
			var ui = GlbUi.LoadUI("Reward")
			ui.Set({"type":"chest","para":GlbDat.RollChest()})
			yield(ui,"finish")
			RefreshMainMenu()
			NextSite()
		"rest":
			GlbDat.chara.Rest()
			NextSite()
		"forge":Forge()
		"shop":
			var shop = GlbUi.LoadUI("Shop")
			yield(shop,"finish")
			NextSite()
		"?":pass
		_:pass
	print_debug("select site:",site)

var enmCnt = 0
func Encounter(type):
	var set
	if enmCnt < GlbDb.lvDb.start.cnt:
		set = RndSelEctMst(GlbDb.lvDb.start.sets)
	else:
		set = RndSelEctMst(GlbDb.lvDb.remains.sets)
	enmCnt += 1
	var data = {"type":type,"set":set}
	TrigBattle(data)

func RndSelEctMst(set):
	var rate_sum:int = 0
	for s in set:
		rate_sum += s.rate
	var val = randi()%rate_sum
	var cnt = 0
	for s in set:
		cnt += s.rate
		if cnt>val:
			return s.mst
	return set[len(set)-1].mst

func GainCard(card):
	GlbDat.chara.cards.append(card.duplicate(true))
	
func CostGold(gold):
	GlbDat.gold -= gold

func TrigBattle(data):
	var tmpList = GetSetEnmLst(data.set)
	if GlbDat.battle!=null:
		GlbDat.battle.queue_free()
		GlbDat.battle = null
	GlbDat.battle = load("res://battle.tscn").instance()
	add_child(GlbDat.battle)
	GlbDat.battle.Start({
		"type":data.type,
		"chara":GlbDat.chara,
		"enm":tmpList
	})

func GetSetEnmLst(set):
	var tmpList = []
	for elmt in set:
		var mst = elmt
		var num = 1
		if elmt.find('*')!=-1:
			var pair = elmt.split('*')
			mst = pair[0]
			num = int(pair[1])
		for n in num:
			if mst.find("|")!=-1:
				var pairs = mst.split('|')
				var rand_sel_mst = pairs[randi()%len(pairs)]
				tmpList.append(rand_sel_mst)
			else:
				tmpList.append(mst)
	return tmpList

func NextSite():
	GlbDat.cur_floor += 1
	EnterSite()

static func CardFilter(list,type):
	var tmp = []
	for card in list:
		if card.type == type:
			tmp.append(card)
	return tmp

static func modDict(dat,dict):
	if !dict.has(dat.type):
		dict[dat.type] = dat.val
	else:
		dict[dat.type] += dat.val
	if dict[dat.type] == 0:
		dict.erase(dat.type)
