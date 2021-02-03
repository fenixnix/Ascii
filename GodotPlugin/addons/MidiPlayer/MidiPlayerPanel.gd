extends Control
signal play(file)

func _on_MidiPanel_play(file):
	print("Play:%s"%file)
	$GodotMIDIPlayer.file = file
	$GodotMIDIPlayer.play()
