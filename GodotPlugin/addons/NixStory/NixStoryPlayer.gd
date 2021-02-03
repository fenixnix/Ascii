extends Node

export(String) var storyScript = ""

var scnDb = {}
var chaDb = {}

var cmd_queue = []
var curIndex = 0

signal finish()

func _ready():
	Clear()
	scnDb = FileRW.LoadJsonFile("res://data/scene.json")
	chaDb = FileRW.LoadJsonFile("res://data/chara.json")
	Narrative.connect("finish",self,"on_finish")
	Dialog.connect("finish",self,"on_finish")

func Clear():
	Scene.Clear()
	Dialog.Close()
	GlbAudio.MuteBGM()
	GlbAudio.MuteEAX()

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
		"scn":
			Scene(dat)
		"!scn":Scene.Clear()
		"nrt":
			Narrative.Print(dat)
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
			GlbAudio.PlaySFX(dat)
		"bgm":
			GlbAudio.PlayBGM(dat)
		_:
			print("unknow cmd")
	Step()

func on_finish():
	print(curIndex)
	Step()

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
