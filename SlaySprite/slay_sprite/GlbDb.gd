extends Node

var cardDict = {}
var enmDict = {}
var statusCardDict = {}
var potionDb = {}
var relicDict = {}

var lvDb = {}

var dbPath = "./data/%s.json"

func _init():
	AppendDict(cardDict,"gray")
	AppendDict(cardDict,"warrior")
	AppendDict(cardDict,"rogue")
	AppendDict(cardDict,"wizard")
	AppendDict(cardDict,"purple")
	
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
	lvDb=LoadDat("enm/enm_ect01")
	

func RandomSelect():
	var index = randi()%len(cardDict.keys())
	return cardDict[cardDict.keys()[index]]

func RandomGainCardByClass(_class,count):
	var tmpList = []
	for card in cardDict.values():
		if card.get("class","all") == _class:
			tmpList.append(card)
	tmpList.shuffle()
	var tmp = []
	for c in count:
		tmp.append(tmpList.pop_front())
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
