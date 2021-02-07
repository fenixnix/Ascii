extends Node

#Godot:function
#posmod
#fposmod
#wrapf
#wrapi
#stepify
#inst2dict
#dict2inst
#to_json
#parse_json
#str2var
#var2str
#str
#get_stack

class_name FileRW

func _ready():
	pass

#static func SelfTest():
#	var val = TestClass.new()
#	var dict = ToStr(val)
#	print("dict-----")
#	print(str(ToStr(val)))
#	print(str(dict2inst(dict)))
#
#	print("json-----")	
#	var json = to_json(val)
#	print(json)
#	var retVal = parse_json(json)
#	print(retVal)
#
#	print("str-----")
#	var valueStr = var2str(val)
#	print(valueStr)
#	retVal = str2var(valueStr)
#	print(retVal)

static func ToStr(dat):
	return inst2dict(dat)
	
static func SaveFile(path,content):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(content)
	file.close()

static func LoadFile(path):
	var file = File.new()
	var err = file.open(path, File.READ)
	if err!=0:
		print_debug("Load File Error %d"%err)
		return ""
	var content = file.get_as_text()
	file.close()
	return content

static func SaveJsonFile(path,json):
	SaveFile(path,JSON.print(json))

static func LoadJsonFile(path):
	var txt = LoadFile(path)
	if txt == "":
		return {}
	return parse_json(LoadFile(path))

static func LoadJsonFileByKey(path,key):
	var tmp = LoadJsonFile(path)
	var tmpDict = {}
	for t in tmp:
		if !t.has(key):
			print_debug("%s not find key!"%t)
		tmpDict[t[key]] = t
	return tmpDict

static func LoadJsonFileArray2Dict(path):
	var dat = LoadJsonFile(path)
	if dat == null:
		return {}
	var tmpDict = {}
	for d in dat:
		tmpDict[d.get("id","")] = d
	return tmpDict

static func LoadTexture(path):
	var tmpTex = ImageTexture.new()
	tmpTex.load(path)
	return tmpTex

static func LoadOGGStream(path):
	var tmpFile = File.new()
	tmpFile.open(path,File.READ)
	var stream = AudioStreamOGGVorbis.new()
	stream.data = tmpFile.get_buffer(tmpFile.get_len())
	tmpFile.close()
	return stream

static func LoadWAVStream(path):
	var snd_file=File.new()
	snd_file.open(path, File.READ)
	var stream = AudioStreamSample.new()
	stream.format = AudioStreamSample.FORMAT_16_BITS
	stream.stereo = true
	stream.data = snd_file.get_buffer(snd_file.get_len())
	snd_file.close()
	return stream

static func LoadVideoStream(path):
	var tmpFile = File.new()
	tmpFile.open(path,File.READ)
	var stream
	var ext = path.get_extension()
	if ext == "ogv":
		stream = VideoStreamTheora.new()
	if ext == "webm":
		stream = VideoStreamWebm.new()
	stream.set_file(path)
	tmpFile.close()
	return stream

static func LoadCSV(file):
	var tmpArr = []
	var csv = LoadFile(file)
	var lst:PoolStringArray = csv.split("\n")
	lst.remove(0)
	for l in lst:
		if len(l)<=0:
			continue
		var dats = l.split(',')
		tmpArr.append(dats)
	return tmpArr

static func GetFileList(path,filter=["*.*"]):
	var tmpList = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var f = dir.get_next()
		if f == "":
			break;
		else:
			for ft in filter:
				if f.match(ft):
					tmpList.append(f)
	return tmpList

static func GetFolderList(path):
	var tmpList = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var f = dir.get_next()
		if f == "":
			break;
		else:
			if !f.match("*.*"):
				tmpList.append(f)
	return tmpList

static func LoadSequnce(path):
	var imgSeq = AnimatedTexture.new()
	var filter = ["*.png","*.jpg","*.bmp","*.svg"]
	var fileList = GetFileList(path,filter)
	imgSeq.frames = len(fileList)
	var id = 0
	for f in fileList:
		imgSeq.set_frame_texture(id,LoadTexture(path+f))
		id+=1
	return imgSeq

static func LoadSpriteFrames(path):
	print("Load Sprite Frame:",path)
	var frames = SpriteFrames.new()
	var filter = ["*.png","*.jpg","*.bmp","*.svg"]
	var fileList = GetFileList(path,filter)
	var id = 0
	for f in fileList:
		var tx = LoadTexture(path+"/"+f)
		frames.add_frame('default',tx,id)
		frames.set_frame("default",id,tx)
		id+=1
	frames.set_animation_speed("default",24)
	frames.set_animation_loop("default",false)
	return frames

func dir_contents(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
