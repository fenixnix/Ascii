extends Node

class_name Weapon

static func CreateByID(id):
	for w in GlbDb.wpnDB:
		if w.id == id:
			return Create(w)
	print_debug("not find wpn id !")
	return {}

static func Create(jsonDat):
	var wpn = jsonDat.duplicate(true)
	if wpn.get("ammo",-1)!=-1:
		wpn.ammo_cap = wpn.ammo
	return wpn

static func Recharge(wpn):
	if wpn.has("ammo"):
		wpn.ammo = wpn.ammo_cap

static func RollDamage(dmg):
	var rnd = dmg.get("rnd",0)
	return ceil(dmg.dmg*rand_range(100-rnd,100+rnd)/100)

static func InitWpnForBtl(dat):
	var data = dat.duplicate(true)
	if data.has("cd"):
		data.cd_cap = dat.cd+1
		data.cd = 0
	return data
