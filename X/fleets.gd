extends Node2D

export(PackedScene) var fleetPrefab

var fleets = {}

func LaunchFleet(from,to,fleet):
	#TODO cost fuel
	var distance = (from.position - to.position).length()/GlbDb.grid_size
	from.res.fuel -= distance
	
	var f = fleetPrefab.instance()
	f.Set(fleet)
	add_child(f)
	f.position = from.position
	f.MoveTo(to)
	from.fleets.erase(fleet)
	for s in fleet.ships:
		if s.get("ofc",null)!=null:
			from.TakeOfficer(s.ofc)

func CreateFromDB(dat):
	var fleet_dat = CreateFleetDatFromDB(dat)
	var fleet = fleetPrefab.instance()
	fleet.Set(fleet_dat)
	add_child(fleet)
	return fleet

func CreateFleetDatFromDB(dat):
	var data = dat.duplicate(true)
	data.ships.clear()
	for s in dat.ships:
		var shipDat = GlbDb.enmShipDB[s].duplicate(true)
		shipDat.hp = 1
		data.ships.append(shipDat)
	return data
