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

static func SelfTest():
	var val = TestClass.new()
	var dict = ToStr(val)
	print("dict-----")
	print(str(ToStr(val)))
	print(str(dict2inst(dict)))
	
	print("json-----")	
	var json = to_json(val)
	print(json)
	var retVal = parse_json(json)
	print(retVal)
	
	print("str-----")
	var valueStr = var2str(val)
	print(valueStr)
	retVal = str2var(valueStr)
	print(retVal)

static func ToStr(dat):
	return inst2dict(dat)
	
static func SaveFile(path,content):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(content)
	file.close()

static func LoadFile(path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
	
static func SaveJsonFile(path,json):
	SaveFile(path,JSON.print(json))

static func LoadJsonFile(path):
	return parse_json(LoadFile(path))
	
static func LoadJsonFileArray2Dict(path):
	var dat = LoadJsonFile(path)
	var tmpDict = {}
	for d in dat:
		tmpDict[d.get("id","")] = d
	return tmpDict
