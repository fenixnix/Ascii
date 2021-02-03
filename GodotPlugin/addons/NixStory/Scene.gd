extends CanvasLayer

var queue = []

var bgPrefab = preload("res://addons/NixStory/Background.tscn")

func Clear():
	for c in get_children():
		c.queue_free()

func PushBG(tx):
	var bg = bgPrefab.instance()
	bg.texture = load(tx)
	Push(bg)

func PushScn(path):
	var scn = load(path).instance()
	Push(scn)

func Push(scn):
	queue.push_back(scn)
	add_child(scn)

func Pop():
	if len(queue)>0:
		queue.pop_back().queue_free()
