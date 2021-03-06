extends Node

var dataPath = "res://data/%s.json"

var db = []

var cardDb = []
var charaDb = []
var enmDb = []
var hidenDb = []

var cardDict = {}

var ectDb = {}
var ectDict = {}

var storyDb = {}
var locDb = {}

var class_icon = {
	"Guardian":"res://image/icon/guardian.png",
	"Mystic":"res://image/icon/mystic.png",
	"Rogue":"res://image/icon/rogue.png",
	"Seeker":"res://image/icon/seeker.png",
	"Survivor":"res://image/icon/survivor.png",
}

var attr_icon_dict = {
	"W":"[color=#008080] %d [font=res://font/icon.tres]p[/font][/color]",
	"I":"[color=#f0f000] %d [font=res://font/icon.tres]b[/font][/color]",
	"C":"[color=#f0f000] %d [font=res://font/icon.tres]c[/font][/color]",
	"A":"[color=#f0f000] %d [font=res://font/icon.tres]d[/font][/color]",
}
 
var class_color = {
	"Guardian":"#2b80c5",
	"Mystic":"#4331b9",
	"Rogue":"#107116",
	"Seeker":"#ec8426",
	"Survivor":"#cc3038",
	"Neutral":"#606060",
	"Mythos":"#000000"
}

var chaos_symbel = {
	"X":"k",
	"@":"l",
	"#":"q",
	"&":"m",
	"*":"o",
}

func _init():
	for f in ["core","y2","y3","y4","y5","y6","y7","y50","y51","y52","y53",
		"y601","y602","y603","y604","y605","y81","y82","y83","y84","y98","y99","y90"]:
		db += LoadDB("db_%s"%f)
		
	#cardDb = LoadDB("card")
	charaDb = LoadDB("chara")
	#charaDb.clear()
	
	storyDb = LoadDB("story/story")
	
	locDb.clear()
	var locJson = LoadDB("story/loc")
	for j in locJson:
		locDb[str(j.id)] = j
	
	var ectJson = LoadDB("ect_set")
	ectDict.clear()
	for ect in ectJson:
		ectDict[ect.name] = ect.set 
	
	for d in db:
		if d["class"] == "Mythos":
			if d["type"] == "Enemy" || d["type"] == "Treachery":
				hidenDb.append(d)
				cardDict[str(d.id)] = d
		match d.type:
#			"Investigator":
#				charaDb.append(d)
			"Asset","Treachery","Event","Skill":
				if d["class"]!="Mythos":
					cardDb.append(d)
					cardDict[str(d.id)] = d
			"Enemy":enmDb.append(d)
	LoadDict("card",cardDict)
#			"Scenario":
#				checkEct(d.encounter)
#				ectDb[d.encounter].scenario = d
#
#			"Location":
#				if !d.has("encounter"):
#					print_debug("not find encounter:",d)
#				else:
#					checkEct(d.encounter)
#					ectDb[d.encounter].loc.append(d)
#
#			"Act":
#				checkEct(d.encounter)
#				ectDb[d.encounter].act.append(d)
#
#			"Agenda":
#				checkEct(d.encounter)
#				ectDb[d.encounter].agenda.append(d)

func checkEct(encounter):
	if !ectDb.has(encounter):
		ectDb[encounter]={
			"scenario":{},
			"loc":[],
			"act":[],
			"agenda":[],
		}

func LoadDB(db):
	return FileRW.LoadJsonFile(dataPath%db)

func LoadDict(db,dict):
	var dat = FileRW.LoadJsonFile(dataPath%db)
	for d in dat:
		dict[str(d.id)] = d

#var rootPath = "res://image/card/%s.%s"
var rootPath = "../card/%s.%s"

onready var dir = Directory.new()
func CardImg(file):
	if dir.file_exists(rootPath%[file,"png"]):
		return FileRW.LoadTexture(rootPath%[file,"png"])
	else:
		return FileRW.LoadTexture(rootPath%[file,"jpg"])

func CardEncounter(dat):
	var ect = dat.get("encounter","").trim_suffix()
