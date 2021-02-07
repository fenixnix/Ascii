extends Control

func _ready():
	$Frame/VBox/HBoxContainer/BGM.value = GlbAudio.bgm.volume_db
	$Frame/VBox/HBoxContainer2/SFX.value = GlbAudio.ui_sfx.volume_db

func _on_BGM_value_changed(value):
	GlbAudio.bgm.volume_db = value

func _on_SFX_value_changed(value):
	GlbAudio.ui_sfx.volume_db = value

func _on_Back_pressed():
	GlbUi.Pop()

func _on_OptionButton_item_selected(index):
	var dict = ["en","zh"]
	TranslationServer.set_locale(dict[index])
