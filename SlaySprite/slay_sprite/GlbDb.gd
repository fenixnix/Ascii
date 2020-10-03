extends Node

var cardDb = []
var cardDict = {}
var enmDict = {}
var statusCardDict = {}

var dbPath = "./data/%s.json"

func _init():
	var res = LoadDb("warrior")
	cardDb = res[0]
	cardDict = res[1]
	enmDict = FileRW.LoadJsonFileArray2Dict(dbPath%"enm/enm")
	res = LoadDb("status")
	statusCardDict = res[1]

func RandomSelect():
	var index = randi()%len(cardDict.keys())
	return cardDict[cardDict.keys()[index]]

func LoadDb(file):
	var db = LoadDat(file)
	var dict = {}
	for d in db:
		dict[d.name] = d
	return [db,dict]

func LoadDat(file):
	return FileRW.LoadJsonFile(dbPath%file)

func CardImage(img):
	return FileRW.LoadTexture("../card/%s.png"%img)
