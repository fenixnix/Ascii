extends CanvasLayer

export(PackedScene) var pt_prefab

onready var cam = get_parent()

func Play(pos,text):
	var pt = pt_prefab.instance()
	add_child(pt)
	pt.position = cam.unproject_position(pos)
	pt.text = text
