extends Node

var fileName = "user://config.json"
var data = {}

func init():
	LoadConfigFile()
	Refresh()

func LoadConfigFile():
	data = FileRW.LoadJsonFile(fileName)

func Refresh():
	var langLst = TranslationServer.get_loaded_locales()
	TranslationServer.set_locale(langLst[data.get("language",0)])
	GlbAudio.bgm.volume_db = data.get("BGM",80)
	GlbAudio.ui_sfx.volume_db = data.get("SFX",80)
