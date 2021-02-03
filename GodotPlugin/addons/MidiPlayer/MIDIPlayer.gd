extends EditorPlugin

var playerPanel
var player

func _enter_tree():
	#playerPanel = preload("MidiPlayerPanel.tscn").instance()
	#add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL,playerPanel)
	
	#player = MidiPlayer.new()
	#add_child(player)
	#playerPanel.connect("play",self,"on_play")
	pass

func _exit_tree():
	#remove_control_from_docks(playerPanel)
	pass

func on_play(file):
	player.file = file
	player.play()
