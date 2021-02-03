extends Node

var data = {"list":[]}
const init_file_path = "user://save_load.json"

func _init():
	print(OS.get_user_data_dir())
	Init()

func Init():
	var dir = Directory.new()
	if dir.file_exists(init_file_path):
		data = FileRW.LoadJsonFile(init_file_path)
	syncInitFile()

func syncInitFile():
	FileRW.SaveJsonFile(init_file_path,data)

func SavLst():
	var tmp = []
	for d in data.list:
		tmp.append(d)
	return tmp

func HasAutoSave():
	return data.get("auto_sav",false)

func AutoSave(dat):
	data.auto_sav = true
	FileRW.SaveJsonFile("user://auto.sav",dat)
	syncInitFile()

func AutoSaveDat():
	return FileRW.LoadJsonFile("user://auto.sav")

func Save(id,savDat):
	FileRW.SaveJsonFile("user://%s.sav"%id,savDat)
	if !data.has("list"):
		data.list = []
	data.list.append({
		"id":id,
		"dt":SysDtStr(),
	})
	syncInitFile()

func OverWrite(index,savDat):
	var id = str(data.list[index].id)
	FileRW.SaveJsonFile("user://%s.sav"%id,savDat)
	for d in data.list:
		if str(d.id) == id:
			d.dt = SysDtStr()
			break
	syncInitFile()

func SysDtStr():
	var dt = OS.get_datetime()
	return "%04d/%02d/%02d-%02d:%02d:%02d"%[
		dt.year,dt.month,dt.day,
		dt.hour,dt.minute,dt.second
	]

func Load(index):
	return FileRW.LoadJsonFile("user://%s.sav"%data.list[index].id)

func Delete(index):
	data.list.remove(index)
	syncInitFile()
