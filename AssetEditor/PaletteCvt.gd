extends Control

func _ready():
	#Learn("res://medieval_tilesheet.png")
	#Remap("res://colored.png")
	pass

func Learn(filePath):
	var palette = Palette.LoadFromImage(filePath)
	print("Palette len:%d,data:%s"%[len(palette),palette])
	FileRW.SaveJsonFile("res://palette.json",palette)

func Remap(filePath):
	var img:Image = load(filePath).get_data()
	var map = FileRW.LoadJsonFile("res://palette.json")
	Palette.Remap(img,map)
	img.save_png("res://dst.png")
