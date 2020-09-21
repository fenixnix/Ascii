extends PopupPanel

onready var data = GameConfig.data

func Open():
	var langLst = TranslationServer.get_loaded_locales()
	var langIndex = langLst.find(TranslationServer.get_locale())
	$Panel/Root/Language/Language.selected = data.get("language",langIndex)
	$Panel/Root/Graphic/HBoxContainer4/FullScreen.pressed = data.get("fullscreen",false)
	$Panel/Root/Audio/HBoxContainer/BGM.value = data.get("BGM",0)
	$Panel/Root/Audio/HBoxContainer3/SFX.value = data.get("SFX",0)
	popup()

func Update():
	GameConfig.Refresh()

func _on_OK_pressed():
	queue_free()

func _on_Cancel_pressed():
	queue_free()

func _on_BGM_value_changed(value):
	data["BGM"] = value
	Update()

func _on_SFX_value_changed(value):
	data["SFX"] = value
	Update()

func _on_OptionButton_item_selected(id):
	data["language"] = id
	Update()
