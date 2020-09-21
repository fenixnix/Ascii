extends Control

var data = []
var current_roi:Rect2

onready var page = $Main/ScrollContainer/Page
onready var item_list = $Main/ItemList

func _on_Load_pressed():
	$LoadImage.popup_centered_ratio()

func _on_LoadImage_file_selected(path):
	page.texture = FileRW.LoadTexture(path)

func Refresh():
	item_list.clear()
	for d in data:
		item_list.add_item("%s:%s"%[d.key,d.type])
	page.DrawDatas(data)

func _on_TextureRect_select_roi(roi):
	$KeyInput.popup(Rect2(get_local_mouse_position(),Vector2.ONE))
	current_roi = roi

func _on_Save_pressed():
	$SaveFile.popup_centered_ratio()

func _on_SaveFile_file_selected(path):
	FileRW.SaveJsonFile(path,data)

func _on_LoadTemplate_pressed():
	$LoadTemplate.popup_centered_ratio()

func _on_LoadTemplate_file_selected(path):
	data = FileRW.LoadJsonFile(path)
	Refresh()

func _on_KeyInput_finish(key, type):
	data.append({"key":key,"roi":current_roi,"type":type})
	Refresh()
