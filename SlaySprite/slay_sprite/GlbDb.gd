extends Node

var cardDict = {}
var enmDict = {}
var statusCardDict = {}
var potionDb = {}
var relicDict = {}

var lvDb = {}

var dbPath = "./data/%s.json"

const cardsFiles = ["gray","status","curse","warrior","rogue","wizard","purple"]

func _init():
	for file in cardsFiles:
		AppendDict(cardDict,file)
	
	AppendDict(relicDict,"relic_All")
	AppendDict(relicDict,"relic_IronClad")
	AppendDict(relicDict,"relic_Silent")
	AppendDict(relicDict,"relic_Defect")
	AppendDict(relicDict,"relic_Watcher")
	
	var res = LoadDb("status")
	statusCardDict = res[1]
	
	potionDb=LoadDat("potion")
	InitPotionDict()
	
	enmDict = FileRW.LoadJsonFileArray2Dict(dbPath%"enm/enm")
	AppendDictByID(enmDict,"enm/elite")
	AppendDictByID(enmDict,"enm/boss")
	lvDb=LoadDat("enm/enm_act1")
	

func RandomSelect():
	var index = randi()%len(cardDict.keys())
	return cardDict[cardDict.keys()[index]]

func RandomShopCard(_class):
	var tmpList = []
	for card in cardDict.values():
		if card.get("class","all") == _class:
			tmpList.append(card)
	
	var attackList = FilterByType(tmpList,"Attack")
	var skillList = FilterByType(tmpList,"Skill")
	var powrList = FilterByType(tmpList,"Power")
	attackList.shuffle()
	skillList.shuffle()
	powrList.shuffle()
	
	var tmp = []
	for c in 2:
		tmp.append(attackList.pop_front())
	for c in 2:
		tmp.append(skillList.pop_front())
	for c in 1:
		tmp.append(powrList.pop_front())
	return tmp

func GetIcon(id):
	return load("res://image/icon/%s.png"%id)

func RandomGrayCard(count):
	var tmpList = []
	for c in cardDict.values():
		if c.get("class","all") == "all":
			if c.rarity == "Common"||c.rarity == "Uncommon":
				tmpList.append(c)
	tmpList.shuffle()
	var tmp = []
	for c in count:
		tmp.append(tmpList.pop_front())
	return tmp

func RandomGainCardByClass(_class,count):
	var rarityDat = {"common":0,"uncommon":0,"rare":0}
	for c in count:
		rarityDat[GlbDat.RollCardRarity()] += 1

	var tmpList = []
	for card in cardDict.values():
		if card.get("class","all") == _class:
			tmpList.append(card)
	
	var commonList = FilterByRarity(tmpList,"Common")
	var uncommonList = FilterByRarity(tmpList,"Uncommon")
	var rareList = FilterByRarity(tmpList,"Rare")
	commonList.shuffle()
	uncommonList.shuffle()
	rareList.shuffle()
	
	var tmp = []
	for c in rarityDat["common"]:
		tmp.append(commonList.pop_front())
	for c in rarityDat["uncommon"]:
		tmp.append(uncommonList.pop_front())
	for c in rarityDat["rare"]:
		tmp.append(rareList.pop_front())
	return tmp

func RandBossCardByClass(class_,cnt = 3):
	var tmp = FilterByClass(cardDict.values(),class_)
	tmp = FilterByRarity(tmp,"Rare")
	tmp.shuffle()
	return tmp.slice(0,cnt-1)

func RandRelicByClass(class_):
	var tmp = FilterByClass(relicDict.values(),"All")
	tmp = FilterByRarity(tmp,"Common")
	return tmp[randi()%len(tmp)]

func RandBossRelicByClass(class_):
	var tmp = FilterByClass(relicDict.values(),class_)
	tmp = FilterByRarity(tmp,"Boss")
	return tmp[randi()%len(tmp)]

func FilterByClass(list,class_):
	var tmp = []
	for l in list:
		if l["class"] == class_:
			tmp.append(l)
	return tmp

func FilterByRarity(list,rarity):
	var tmp = []
	for l in list:
		if l.rarity == rarity:
			tmp.append(l)
	return tmp

func FilterByType(list,type):
	var tmp = []
	for l in list:
		if l.type == type:
			tmp.append(l)
	return tmp

func RndSelCard(cnt):
	var lst = cardDict.keys().duplicate(true)
	lst.shuffle()
	var tmp = []
	for c in cnt:
		tmp.append(cardDict[lst.pop_front()].duplicate(true))
	return tmp

func LoadDb(file):
	var db = LoadDat(file)
	var dict = {}
	for d in db:
		dict[d.name] = d
	return [db,dict]

func AppendDict(db,file):
	var tmp = LoadDat(file)
	for d in tmp:
		db[d.name] = d

func AppendDictByID(db,file):
	var tmp = LoadDat(file)
	for d in tmp:
		db[d.id] = d

func LoadDat(file):
	return FileRW.LoadJsonFile(dbPath%file)

func CardImage(img):
#	return FileRW.LoadTexture("../card/%s.png"%img)
	return FileRW.LoadTexture("res://image/card/%s.png"%img)

const potion_img_path = "res://image/potion/"
var potionImgDict = {}
func InitPotionDict():
	var lst = FileRW.GetFolderList(potion_img_path)
	for l in lst:
		var tmpList = []
		var fileList = FileRW.GetFileList(potion_img_path+l+"/","*.png")
		tmpList.append(findInList(["outline"],fileList))
		tmpList.append(findInList(["body","glass"],fileList))
		tmpList.append(findInList(["hybrid"],fileList))
		tmpList.append(findInList(["liquid"],fileList))
		tmpList.append(findInList(["spots"],fileList))
		potionImgDict[l] = tmpList

func RandomPotionByRarity(rarity):
	var set = potionDb[rarity]
	return set[randi()%len(set)].duplicate(true)

func findInList(keys,list):
	for l in list:
		for key in keys:
			if l.match("*%s*.png"%key):
				return l
	return false
