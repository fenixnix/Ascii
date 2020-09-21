class_name Ship

static func CreateShip(data):
	var ship = data.duplicate(true)
	ship.erase('cost')
	ship.erase('time')
	ship.hp = 1
	ship.wpns = []
	ship.eqps = []
	for i in data.slots.wpn:
		ship.wpns.append({"slot":null})
	for i in data.slots.eqp:
		ship.eqps.append({"slot":null})
	#add default weapon
	ship.wpns[0].slot = Weapon.CreateByID("flak_0")
	return ship

static func CreateNpcShip(data,wpn_dat):
	var ship = data.duplicate(true)
	ship.wpns.clear()
	for w in data.wpns:
		ship.wpns.append({"slot":Weapon.Create(wpn_dat[w])})
	ship.hp = 1
	return ship

static func CreateShipByID(id):
	for ship in GlbDb.shipDB:
		if ship.id == id:
			return CreateShip(ship)
	print_debug("invalid ship id: %s"%id)
	return {}
