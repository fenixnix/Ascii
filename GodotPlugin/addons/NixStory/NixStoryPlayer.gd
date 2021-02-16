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

var stream

signal finish()

func _ready():
	Clear()
	stream = Narrative
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
	cmd_queue = skipCommon(txt)
	Step()

func skipCommon(txt):
	var que = []
	for t in txt.split('\n'):
		var line = t.dedent()
		if not line.begins_with("//"):
			que.append(line)
	return que

func Step():
	if curIndex>=len(cmd_queue):
		emit_signal("finish")
		#Clear()
		return

	var line = cmd_queue[curIndex].dedent()
	curIndex += 1
	if Command(line):
		return

	stream.Print(line+"\n")
	Step()

func on_finish():
	print(curIndex)
	Step()

func Command(line):
	for k in [">>","<>"]:
		if cmd(line,k):
			return true
	for k in ["VAR","#","===","=","->","*","+","!"]:
		if cmd(line,k):
			Step()
			return true
	return false

func cmd(line,key):
	if line.begins_with(key):
		var cmd = line.lstrip(key).dedent()
		print(cmd)
		match key:
			"VAR":GlbVar(cmd)
			"#":Tags(cmd)
			"*":PushOption(cmd)
			"+":PushOption(cmd)
			"!":
				stream.Print(cmd+"\n")
				cmd_queue.remove(curIndex-1)
				curIndex -= 1
			"<>":pass
			"->":Goto(cmd)
			_:pass
		return true
	return false

func GlbVar(line):
	var pair = line.split('=')
	gameDb[pair[0].dedent()] = pair[1].dedent()

func Tags(line):
	var cmd = line
	var dat = ""
	if ':' in line:
		var cmdIndex = line.find(':')
		cmd = line.left(cmdIndex)
		dat = line.right(cmdIndex+1)
	print("Tags %s:%s"%[cmd,dat])
	match cmd:
		"bg":Scene.PushBG("%s/%s"%[rootPath,dat])
		"scn":
			Scene(dat)
		"!scn":Scene.Clear()
		"nrt":stream = Narrative
		"dlg":stream = Dialog
		"clear":stream.Clear()
		"close":stream.Close()
		"cha":
			var chaDat = chaDb[dat]
			Dialog.SetSpeaker(chaDat.get("name","???"),
				load(chaDat.get("portrait",[])[0]))
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
		"->":Goto(dat)
		_:
			stream.Print(line)

func PushOption(line):
	pass

func Goto(tag):
	print_debug("goto %s"%tag)
	var index = 0
	for c in cmd_queue:
		if c.begins_with("==="):
			if c.lstrip("===").dedent() == tag:
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
