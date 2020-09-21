extends Node2D

class_name Site

enum{VIEW,SELECT}
var ui_mode = VIEW

var site_name = "none"
var trait = "none"
var type = "nebula"

var team:int = -1 setget set_team

var hp = 1
var mhp = 100
var tech = 0
var indu = 0

var res = {}

var regions = []
var ofcs = []
var ships = []
var wpns = []
var eqps = []
var fleets = []

signal selected(site)

var data = [
	"nebula",
	"planetary",
	"asteroid",
	"pulsar",
]

func set_team(_team):
	team = _team
	update()

func SetUiMode(mode):
	match mode:
		"view":ui_mode = VIEW
		"select":ui_mode = SELECT

func RandInit():
	var index = randi()%len(data)
	Init(data[index])

func Init(_type):
	type = _type
	$Sprite.texture = load(GlbDb.site_img[type])

func InitFromJsonDat(jsonDat):
	site_name = jsonDat.name
	team = int(jsonDat.get("team",0))
	Init(jsonDat.type)
	res = jsonDat.get("res",{}).duplicate(true)
	ships.clear()
	for s in jsonDat.get("ships",[]):
		ships.append(Ship.CreateShipByID(s))
	fleets.clear()
	for f in jsonDat.get("fleets",[]):
		var fleet = f.duplicate(true)
		fleet.ships.clear()
		for s in f.ships:
			fleet.ships.append(Ship.CreateShipByID(s))
		fleets.append(fleet)
	wpns.clear()
	for w in jsonDat.get("wpns",[]):
		wpns.append(Weapon.CreateByID(w))
	#TODO:regions,wpns,eqps

func HourTick():
	for r in regions:
		Region.Tick(r,self)


func PowerGen():
	return Region.GenPower(regions)

func PowerCost():
	return Region.CostPower(regions)

func CheckBuildValid(facility):
	if facility.has("power"):
		if PowerCost() + facility.get("power",0) > PowerGen():
			return false
	for ck in facility.cost:
		if facility.cost[ck]>res[ck]:
			return false
	return true

var lab
var show_neigh = false
func _on_Area2D_mouse_entered():
	show_neigh = true
	update()
	lab = GlbUi.ShowSiteTip(self)
	
func _on_Area2D_mouse_exited():
	show_neigh = false
	update()
	if is_instance_valid(lab):
		lab.queue_free()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == 1 && event.pressed:
		if ui_mode == VIEW:
			GlbUi.ShowSiteInfo(self)
			GlbDat.currentSite = self
			GlbTime.running = false
		if ui_mode == SELECT:
			emit_signal("selected",self)

func SetFleet(fleet):
	fleet.position = position+Vector2.ONE*32
	fleets.append(fleet)

func CheckFleetAfterBattle():
	print_debug("Check Fleet After Battle")
	for f in fleets:
		if len(f.ships) == 0:
			fleets.erase(f)

func TakeOfficer(officer):
	ofcs.erase(officer)
	#TODO Rmv from Region & Facility

func TakeResource(cost):
	for c in cost.keys():
		res[c] -= cost[c]

func PutResource(_res):
	for k in _res.keys():
		if !res.has(k):
			res[k] = 0
		res[k] += _res[k]

func _draw():
	if show_neigh:
		nearest3site()
		
	draw_arc(Vector2.ZERO,32,0,PI+PI,32,
	GlbDb.faction_color[team])
	if hp<1:
		draw_arc(Vector2.ZERO,24,0,PI*2*hp,32,
		lerp(Color.red,Color.green,hp),2,true)

func nearest3site():
	var pts = site_map.nearst3points(self,get_parent().get_children())
	for p in pts:
		draw_circle(p-position,32,Color(0,1,.5,.5))
