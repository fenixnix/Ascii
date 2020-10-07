extends Node

var cardDb = []
var cardDict = {}
var enmDict = {}
var statusCardDict = {}
var potionDb = {}

var lvDb = {}

var dbPath = "./data/%s.json"

func _init():
	var res = LoadDb("warrior")
	cardDb = res[0]
	cardDict = res[1]
	enmDict = FileRW.LoadJsonFileArray2Dict(dbPath%"enm/enm")
	res = LoadDb("status")
	statusCardDict = res[1]
	potionDb=LoadDat("potion")
	lvDb=LoadDat("enm/enm_ect01")
	
	InitPotionDict()

func RandomSelect():
	var index = randi()%len(cardDict.keys())
	return cardDict[cardDict.keys()[index]]

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
