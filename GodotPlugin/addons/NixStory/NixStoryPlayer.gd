extends Node

export(String,DIR) var rootPath = "res://"
export(String,FILE,"*.json") var sceneDB
export(String,FILE,"*.json") var charaDB
export(String,FILE,"*.nvs") var storyScript

var scnDb
var chaDb

var gameDb = {}

var cmd_queue = []
var curIndex = 0

signal finish()

func _ready():
	Clear()
	scnDb = FileRW.LoadJsonFile(sceneDB)
	chaDb = FileRW.LoadJsonFile(charaDB)
	Narrative.connect("finish",self,"on_finish")
	Dialog.connect("finish",self,"on_finish")
	pass

func Clear():
	Scene.Clear()
	Narrative.Close()
	Dialog.Close()

func Play(story = null):
	if story != null:
		storyScript = story
	var txt = FileRW.LoadFile(storyScript)
	print("Play Script:%s"%storyScript)
	curIndex = 0
	cmd_queue.clear()
	cmd_queue = txt.split('\n')
	Step()

func Step():
	if curIndex>=len(cmd_queue):
		emit_signal("finish")
		Clear()
		return
		
	var line = cmd_queue[curIndex]
	var cmdIndex = line.find(':')
	var cmd = line.left(cmdIndex)
	var dat = line.right(cmdIndex+1)
	print("%s:%s"%[cmd,dat])

	curIndex += 1
	match cmd:
		"bg":Scene.PushBG("%s/%s"%[rootPath,dat])
		"scn":
			Scene(dat)
		"!scn":Scene.Clear()
		"nrt":
			Narrative.Print(dat)
			return
		"nrtl":
			Narrative.Print(dat+"\n")
			return
		"#nrt": Narrative.Clear()
		"!nrt": Narrative.Close()
		"cha":
			var chaDat = chaDb[dat]
			Dialog.SetSpeaker(chaDat.get("name","???"),
				load(chaDat.get("portrait",[])[0]))
		"say":
			Dialog.Say(dat)
			return
		"sayl":
			Dialog.Say(dat+"\n")
			return
		"#say":Dialog.Clear()
		"!say":Dialog.Close()
		"se":
			GlbAudio.PlaySFX(rootPath + "/" + dat)
		"eax":
			GlbAudio.PlayEAX(rootPath + "/" + dat)
		"bgm":
			GlbAudio.PlayBGM(rootPath + "/" + dat)
		"select":
			var options = dat.split("|")
			var selLst = []
			var jumpLst = []
			for o in options:
				var pair = o.split("@")
				selLst.append(pair[0])
				jumpLst.append(pair[1])
			GlbUI.ExOption(selLst)
			var selection = yield(GlbUI,"select")
			Goto(jumpLst[selection])
		"goto":Goto(dat)
		_:
			print("unknow cmd")
	Step()

func on_finish():
	print(curIndex)
	Step()

func Goto(tag):
	var index = 0
	for c in cmd_queue:
		if c.begins_with("*"):
			if c.right(1) == tag:
				break
		index += 1;
	print("goto %d"%index)
	curIndex = index

func Scene(dat):
	var scnDat = scnDb[dat]
	for k in scnDat.keys():
		match k:
			"tscn":Scene.PushScn(scnDat[k])
			"bg":for b in scnDat[k]:
				Scene.PushBG(b)
			"eax":GlbAudio.PlayEAX(scnDat[k])
			"bgm":GlbAudio.PlayBGM(scnDat[k])
			_:print("unknow cmd:%s"%scnDat[k])

func GetDB(key):
	return gameDb.get(key,null)

func SetDB(key,val):
	gameDb[key] = val
