extends Control

signal load_game(id)
signal save_game(id)
signal overwrite_game(index)
signal new_game()

func Resume(status):
	$VBox/Resume.visible = status
	$VBox/HSeparator.visible = status

func _ready():
	$SaveList.hide()
	$Label.text = ProjectSettings["application/config/name"]

func _on_Resume_pressed():
	GlbUi.Pop()

func _on_Exit_pressed():
	var ui = GlbUi.Load(GlobalUI.defaultPath%"MessageBox")
	ui.Set(tr("Quit Game ?"))
	ui.connect("result",self,"on_exit")

func on_exit(res):
	if res == "ok":
		get_tree().quit()
		#TODO: for Debug skip AutoSave
		#GlbAct.AutoSave()

func _on_Setting_pressed():
	GlbUi.Push(GlobalUI.defaultPath%"Setting")

func _on_Save_pressed():
	$SaveList.Save()

func _on_Load_pressed():
	$SaveList.Load()

func on_LoadSavDat(index):
	queue_free()

func on_SendSaveID(id):
	emit_signal("save_game",id)

func _on_New_pressed():
	GlbUi.Pop()
	emit_signal("new_game")

func _on_SaveList_action(cmd, index):
	match cmd:
		"new":
			$TextInput.Open()
		"del":
			SL.Delete(index)
			$SaveList.refresh_list()
		"save":
			emit_signal("overwrite_game",index)
		"load":
			emit_signal("load_game",index)
			queue_free()
		_:pass
