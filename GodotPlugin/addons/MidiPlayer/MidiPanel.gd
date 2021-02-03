extends PanelContainer

var folder = ""
var fileList = []
var curIndex = 0

signal play(file)

func _on_Folder_pressed():
	$FileDialog.popup_centered_ratio()

func _on_FileDialog_dir_selected(dir):
	folder = dir
	fileList.clear()
	for l in FileRW.GetFileList(folder,["*.mid"]):
		fileList.append(l)
	fileList.sort()
	$VBoxContainer/ItemList.clear()
	for f in fileList:
		$VBoxContainer/ItemList.add_item(f)

func _on_ItemList_item_activated(index):
	curIndex = index
	playIndex(curIndex)

func playIndex(index):
	emit_signal("play",folder +"/"+ fileList[index])

func _on_GodotMIDIPlayer_finished():
	match $VBoxContainer/HBoxContainer/OptionButton.selected:
		0:playIndex(curIndex)
		1:playIndex(posmod(curIndex +1, len(fileList)))
		2:playIndex(randi()%len(fileList))
