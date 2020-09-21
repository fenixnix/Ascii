extends Node2D

export(PackedScene) var enmPrefab

onready var path = $Path2D

var towers = {}

var currentGridPos = Vector2(0,0)
var currentTower

signal select_grid(id)

func _ready():
	Spawn()

func Spawn():
	var follow = TDPathFollow.new()
	var enm = enmPrefab.instance()
	follow.follower = enm
	path.add_child(follow)
	follow.add_child(enm)
	
func GetGrid():
	var pos = $TowerBase.world_to_map(get_global_mouse_position())
	currentGridPos = pos
	var index = var2str(pos)
	if towers.has(index):
		currentTower = towers[index]
		return currentTower
	var cell = $TowerBase.get_cellv(pos)
	if cell == 2:
		return "base"
	return "empty"

func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		var id = GetGrid()
		emit_signal("select_grid",id)

func Build(id):
	var tower
	match id:
		"gartlin":tower = load("res://TopDownShootGame/Tower/gartlin.tscn").instance()
		"shotgun":tower = load("res://TopDownShootGame/Tower/shotgun.tscn").instance()
		"cannon":tower = load("res://TopDownShootGame/Tower/cannon.tscn").instance()
		"missle":tower = load("res://TopDownShootGame/Tower/missle_launcher.tscn").instance()
	tower.position = (currentGridPos+Vector2(.5,.5))*$TowerBase.cell_size
	$Tower.add_child(tower)
	towers[var2str(currentGridPos)]=tower

func Demount():
	towers.erase(var2str(currentGridPos))
	currentTower.queue_free()
