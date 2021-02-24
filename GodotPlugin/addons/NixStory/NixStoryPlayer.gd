extends Node

export(String,DIR) var rootPath = "res://"
export(String,FILE,"*.json") var sceneDB
export(String,FILE,"*.json") var charaDB
export(String,FILE,"*.ink") var storyScript

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
	#print("index:%d"%curIndex)
	if curIndex>=len(cmd_queue):
		emit_signal("finish")
		#Clear()
		return

	var line = cmd_queue[curIndex].dedent()
	curIndex += 1
	if Command(line):
		return

	stream.Push(line+"\n")
	yield(stream,"finish")
	Step()

func on_finish():
	print("finish Step: %d"%curIndex)
	Step()

func Command(line):
	for k in ['>','<>','*','+']:
		if cmd(line,k):
			return true
	for k in ["VAR","~","#","===","=","->","!"]:
		if cmd(line,k):
			Step()
			return true
	return false

func cmd(line,key):
	if line.begins_with(key):
		var cmd = line.lstrip(key).dedent()
		print(cmd)
		match key:
			"VAR","~":GlbVar(cmd)
			"#":Tags(cmd)
			"*","+":PushOption(line)
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
	#print("Tags %s:%s"%[cmd,dat])
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
				load(rootPath + "/" + chaDat.get("portrait",[])[0]))
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
		_:
			print_debug("unknow tag:%s"%line)

var optionQueue = []
var optionLineIndexs = []
func PushOption(line):
	optionQueue.clear()
	optionLineIndexs.clear()
	var option_mark = leaderMark(line)
	var curLineIndex = curIndex-1
	while true:
		var l = cmd_queue[curLineIndex].dedent()
		print(l)
		if leaderMark(l) == (option_mark):
			optionQueue.append(l.replace(option_mark,''))
			optionLineIndexs.append(curLineIndex)
			#print("Push %d"%curLineIndex)
		if (l.begins_with("-")||l.begins_with("=") )&&( not l.begins_with("->")):
			break
		curLineIndex+=1
	curIndex = curLineIndex
	GlbUI.ExOption(optionQueue)
	var selection = yield(GlbUI,"select")
	#stream.Print(optionQueue[selection]+"\n")
	curIndex = optionLineIndexs[selection]+1
	print("Select %d"%curIndex)
	Step()

func leaderMark(line):
	var start_mark = line.left(1)
	var leader_mark = ""
	for c in line:
		if c == start_mark:
			leader_mark += c
		else:
			break
	return leader_mark

func Goto(tag):
	print_debug("goto %s"%tag)
	var index = 0
	for c in cmd_queue:
		if c.begins_with("="):
			if c.replace("=",'').dedent() == tag:
				break
		index += 1;
	print("goto %d"%index)
	curIndex = index

func Scene(dat):
	var scnDat = scnDb[dat]
	for k in scnDat.keys():
		match k:
			"tscn":Scene.PushScn(rootPath +'/'+ scnDat[k])
			"bg":for b in scnDat[k]:
				Scene.PushBG(rootPath +'/'+ b)
			"eax":GlbAudio.PlayEAX(rootPath +'/'+ scnDat[k])
			"bgm":GlbAudio.PlayBGM(rootPath +'/'+ scnDat[k])
			_:print("unknow cmd:%s"%scnDat[k])

func GetDB(key):
	return gameDb.get(key,null)

func SetDB(key,val):
	gameDb[key] = val
