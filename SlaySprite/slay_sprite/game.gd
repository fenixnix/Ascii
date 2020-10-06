extends Node

func _ready():
	seed(OS.get_system_time_msecs())
	GlbDat.chara = Chara.new()
	GlbDat.chara.Set(GlbDb.LoadDat("ironclad_default"))
	
	GlbDat.currentLevel = 0
	GlbDat.map = FileRW.LoadJsonFile("res://data/map/map01.json")
	
	GlbAct.EnterSite()
