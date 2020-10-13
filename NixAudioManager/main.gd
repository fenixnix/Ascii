extends Control

var root_path
var file_list

var current_length = 0

func _on_OpenFolder_pressed():
	$FileDialog.popup_centered_ratio()

func _on_FileDialog_dir_selected(dir):
	root_path = dir
	$Menu/Path.text = root_path
	refresh_item_list(root_path)

func refresh_item_list(path):
	$ItemList.clear()
	file_list = FileRW.GetFileList(path,["*.ogg","*.wav"])
	for l in file_list:
		$ItemList.add_item(l)

func _on_ItemList_item_selected(index):
	$AudioStreamPlayer.stream = FileRW.LoadOGGStream("%s/%s"%[root_path,file_list[index]])
	current_length = $AudioStreamPlayer.stream.get_length()
	$AudioStreamPlayer.play()

func _on_volume_value_changed(value):
	$AudioStreamPlayer.volume_db = value

func _on_Loop_toggled(button_pressed):
	$AudioStreamPlayer.stream.loop = button_pressed

func _process(delta):
	if $AudioStreamPlayer.is_playing():
		var cur = $AudioStreamPlayer.get_playback_position()
		$ProgressLabel.text = "%d / %d"%[cur,current_length]
		#$progress.value = cur/current_length*100

func _on_progress_value_changed(value):
	var pos = value*current_length/100
	$AudioStreamPlayer.play(pos)
