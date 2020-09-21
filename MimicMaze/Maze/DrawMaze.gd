extends Node2D

export(PackedScene) var layerPrefab

#var maze:Maze3D = null
var avatar = null
#var fog:Grid
#var bgColor = Color(0,0,0,0.8)
#var wallColor = Color(1,0.1,0.5,1)

var layers = []

func Set(maze,fog,_avatar):
	avatar = _avatar
	ClearLayer()
	for l in maze.size[2]:
		var layer = layerPrefab.instance()
		add_child(layer)
		layers.append(layer)
		layer.maze = maze
		layer.fog = fog
		layer.layer = l
	yield(get_tree(),"idle_frame")
	Refresh()

func AddObj(obj,z):
	layers[z].add_child(obj)

func ClearLayer():
	for l in layers:
		l.queue_free()
	layers.clear()

func Up():
	var cLayer = layers[avatar.location[2]]
	var nLayer = layers[avatar.location[2]-1]
	cLayer.visible = true
	nLayer.visible = true
	cLayer.DownFadeOut()
	nLayer.DownFadeIn()

func Down():
	var cLayer = layers[avatar.location[2]]
	var nLayer = layers[avatar.location[2]+1]
	cLayer.visible = true
	nLayer.visible = true
	cLayer.UpFadeOut()
	nLayer.UpFadeIn()

func Refresh():
	for l in layers:
		l.visible = (avatar.location[2] == l.layer)
		l.update()
