extends Node

var cardDb = []
var cardDict = {}

func _init():
	var res = LoadDb("ironclad")
	cardDb = res[0]
	cardDict = res[1]

var dbPath = "./data/%s.json"
func LoadDb(file):
	var db = LoadDat(file)
	var dict = {}
	for d in db:
		dict[d.name] = d
	return [db,dict]
	
func LoadDat(file):
	return FileRW.LoadJsonFile(dbPath%file)

func CardImage(img):
	#return FileRW.LoadTexture("./card/%s.png"%img)
	return load("res://image/Immolate.png")
