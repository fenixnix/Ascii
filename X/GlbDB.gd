extends Node

var grid_size = 64

onready var ofcDB = FileRW.LoadJsonFile("res://data/ofc.json")

var shipDB = []
var wpnDB = []
var eqpDB = []
var enmShipDB = []
var enmFleetDB = []

onready var xeno_ship = FileRW.LoadJsonFile("res://data/xeno_ship.json")
onready var xeno_wpn = FileRW.LoadJsonFile("res://data/xeno_wpn.json")

var expTable = [5,35,60,150,200,300,400,500,650,800,1200,2000,3200,4000]

var default_officer_portrait = "res://images/portrait/computer.png"

#dmg type:
enum WPN_TYPE{
	flak,
	laser,
	missle,
	beam,
	ion,
	cannon,
	bomb,shrapnel,
	wave,crystal,railgun
	}

var faction_color = {
	-1:Color.gray,
	0:Color(0,.5,1),
	1:Color.red,
}

var faction_name = [
	"Terran",
	"Chruul",
	"",
]

var faction_img = [
	"res://images/faction/faction_terran.png",
	"res://images/faction/faction_pirate.png",
	"res://images/faction/faction_chruul.png",
	"res://images/faction/faction_xlar.png",
	"res://images/faction/faction_collective.png",
	"res://images/faction/faction_korzan.png",
	"res://images/faction/faction_yabbling.png",
	"res://images/faction/faction_voraash.png",
	"res://images/faction/faction_spacewhale.png",
	"res://images/faction/faction_spacemonster.png",
]

var site_img = {
	"nebula":"res://images/helix_neb.png",
	"planetary":"res://images/sector1.png",
	"asteroid":"res://images/asteroids.png",
	"pulsar":"res://images/pulsar.png",
	"spawn":"res://images/desecrated_sector.png",
	"nest":"res://images/chruul_spire.png",
}

var cls_dict = {
	"tac":"Tactical",
	"eng":"Engineering",
	"sci":"Scientist"
}

var att_color_dict = {
	"ENG":Color.yellow,
	"SCI":Color.aqua,
	"TAC":Color.red
}

var resist_dict = {
	"phy":"Physical",
	"ene":"Energy",
}

var resist_eot_dict={
	"acc-":"Sensors Offline",
	"spd-":"Engines Down",
	"evd-":"Crew Panic",
	"dmg-":"Weapons Disruption",
	"def-":"Vulnerable",
	"dot":"Hull Breach",
	"stun":"Ship Disable",
}

var res_dict = {
	"crew":"Crew",
	"mtrl":"Material",
	"dkmt":"Darkmatter",
	"fuel":"Fuel",
	"atmt":"AntiMatter",
	"plsm":"Plasma",
	"nano":"Nano Fibres",
	"bio":"Biowaste"
}

#nebula:"Fuel Refinery" 2~3/D 20~30 "res://images/nebula.png"
#planetary:"Colony" 2~3/D 20~30 "res://images/sector1.png"
#asteroid:"Materails Mine" 4~6/D 100~200 "res://images/asteroids.png"
#pulsar:"Dark Matter Extractor" 4~6/D 100~200 "res://images/pulsar.png"
var site_bg = {
	"nebula":"res://images/nebula.png",
	"planetary":"res://images/sector1.png",
	"asteroid":"res://images/asteroids.png",
	"pulsar":"res://images/pulsar.png",
	"spawn":"res://images/desecrated_sector.png",
	"nest":"res://images/chruul_spire.png",
}

var icon_dict = {
	"crew":"res://images/crew.png",
	"mtrl":"res://images/materials.png",
	"dkmt":"res://images/dark_matter.png",
	"fuel":"res://images/fuel.png",
	"power":"res://images/energy.png",
}

var icon_font = {
	"time":0xf017,
	"power":0xf0e7,
	"tech":0xf0e8,
	"ofc":0xf2bd,
	"trade":0xf24f,
	"money":0xf0d6,
	"btc":0xf15a,
	"warning":0xf071,
	"mark":0xf041,
	"bell":0xf0a2,
	"space_ship":0xf197,
	"fcty":0xf275,
	"edit":0xf044,
}

func FontIcon(id):
	return "[font=res://font/icon_font.tres]%s[/font]"%char(icon_font[id])

func _init():
	shipDB = FileRW.LoadJsonFile("res://data/ship.json")
	enmShipDB = FileRW.LoadJsonFile("res://data/enm_ship.json")
	enmFleetDB = FileRW.LoadJsonFile("res://data/enm_fleet.json")
	wpnDB = FileRW.LoadJsonFile("res://data/wpn.json")
	eqpDB = FileRW.LoadJsonFile("res://data/eqp.json")

static func LoadDB(path):
	return FileRW.LoadJsonFile("res://data/"+path)
