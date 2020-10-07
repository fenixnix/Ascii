extends HBoxContainer

onready var placeHolderIcon = preload("res://image/potion/potion_placeholder.png")
onready var potionPrefab = preload("res://Potion.tscn")

func Set(slots):
	for c in get_children():
		c.queue_free()
	yield(get_tree(),"idle_frame")
	for s in slots:
		if s.potion==null:
			var placeHolder = TextureRect.new()
			placeHolder.texture = placeHolderIcon
			add_child(placeHolder)
		else:
			var potion = potionPrefab.instance()
			add_child(potion)
