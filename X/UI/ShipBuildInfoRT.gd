extends RichTextLabel

class_name ShipBuildInfoRT

func _ready():
	bbcode_enabled = true

func Set(dat):
	bbcode_text = InfoText(dat)

func InfoText(dat):

	text = """
	[center][font=res://font/optimus_font.tres]%s[/font][color=#80ffff]
	[s]                        [/s][/color]
	
	[img]%s[/img][/center]
	
	[color=#80ffff]Race:[/color] %s
	[color=#80ffff]Class:[/color] %s
	[color=#80ffff]Tier:[/color] %d
	
	[color=#80ffff]Cost[/color] %s 
	%s
	
	HP: %d
	\u2629ACC:[color=yellow]%3d%%[/color]	\u219dEVD:[color=yellow]%3d%%[/color]
	\u2736CRT:[color=yellow]%3d%%[/color]	\u2708SPD:[color=yellow]%3d[/color]
	
	[color=#80ffff]Weapon Slot:[/color] %d [color=#80ffff]Equipment Slot:[/color] %d
	
	%s
	%s
"""%[
	dat.get("name","none"),
	dat.img,
	dat.info.race,
	dat.info.cls,
	dat.info.tier,
	BBCode.resource(dat.get("cost",[])),
	BBCode.build_time(dat.get("time",0)),
	dat.status.hull,
	dat.status.acc,
	dat.status.evd,
	dat.status.crt,
	dat.status.spd,
	dat.slots.wpn,
	dat.slots.eqp,
	BBCode.resist(dat),
	BBCode.resist_eot(dat),
]
	return text
