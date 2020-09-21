extends Node

onready var fleets = $'/root/Main/StarMap/fleets'
onready var sites = $'/root/Main/StarMap/sites'
onready var ship_dat = GlbDb.LoadDB("xeno_ship.json")
onready var wpn_dat = GlbDb.LoadDB("xeno_wpn.json")

var radius = 500

func OnDayTick():
	if CountXenoSite()<=3:
		GenSpawnSite(Vector2(rand_range(-500,500),rand_range(-500,500)))

func GenSpawnSite(position):
	var new_site = load("res://site.tscn").instance()
	new_site.team = int(1)
	new_site.Init("spawn")
	sites.add_child(new_site)
	new_site.position = position
	new_site.fleets.append(CreateXenoFleet())

func CreateXenoFleet():
	return RandomXenoFleet(randi()%7)
#	var fleet_dat = GlbDb.LoadDB("xeno_fleet.json")
#	var ship_dat = GlbDb.LoadDB("xeno_ship.json")
#	var data = fleet_dat[0].duplicate(true)
#	var fleet = {
#		"name":"Xeno",
#		"team":1,
#		"ships":[]
#	}
#	for s in data.ships:
#		var ship = ship_dat[s].duplicate(true)
#		ship.hp = 1
#		fleet.ships.append(ship)
#	return fleet

func RandomXenoFleet(dif):
	var fleet = {
		"name":"Xeno",
		"team":1,
		"ships":[]
	}
	match dif:
		0:RandShipsByTier(fleet,0,2)
		1:RandShipsByTier(fleet,0,3)
		2:
			RandShipsByTier(fleet,0,1)
			RandShipsByTier(fleet,1,1)
		3:
			RandShipsByTier(fleet,0,2)
			RandShipsByTier(fleet,1,1)
		4:
			RandShipsByTier(fleet,1,2)
		5:
			RandShipsByTier(fleet,1,2)
			RandShipsByTier(fleet,0,1)
		6:
			RandShipsByTier(fleet,1,3)
	return fleet

func RandShipsByTier(fleet,tier,cnt=1):
	for i in cnt:
		fleet.ships.append(RandomCreateShipByTier(tier))

func RandomCreateShipByTier(tier):
	var ships = []
	for s in ship_dat:
		if s.tier == tier:
			ships.append(s)
	var shipDat = ships[randi()%len(ships)]
	return Ship.CreateNpcShip(shipDat,wpn_dat)

func CountXenoSite():
	var cnt = 0
	for s in sites.get_children():
		if s.type == "spawn":
			cnt += 1
	return cnt
