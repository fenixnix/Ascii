extends Node

func _ready():
	pass # Replace with function body.

func _on_TD_Map_select_grid(id):
	$TD_HUD.SelectGrid(id)

func _on_TD_HUD_select_action(action):
	print(TdGlb.tower_types)
	if TdGlb.tower_types.has(action):
		$TD_Map.Build(action)
		return
	match action:
		"demount":$TD_Map.Demount()
