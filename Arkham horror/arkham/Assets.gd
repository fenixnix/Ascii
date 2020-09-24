extends VBoxContainer

onready var asset_prefab = preload("res://Asset.tscn")

func Set(assets):
	for c in get_children():
		c.queue_free()
	yield(get_tree(),"idle_frame")
	for a in assets:
		var asset = asset_prefab.instance()
		add_child(asset)
		asset.Set(a)
