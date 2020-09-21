extends Node

class_name BBCode

static func resist(dat):
	var txt = ""
	var res = dat.get("res",{})
	if len(res)>0:
		txt += "[color=#80ffff]-RESISTANCE-------------[/color]\n"
	for k in res.keys():
		txt += "\t[color=#80ff80]%s[/color] : %d%%\n"%[GlbDb.resist_dict[k],res[k]]
	return txt

static func resist_eot(dat):
	var txt = ""
	var res_eot = dat.get("res_eot",{})
	if len(res_eot)>0:
		txt += "[color=#80ffff]-STATUS-RESISTANCE------[/color]\n"
	for k in res_eot.keys():
		txt += "\t[color=#80ff80]%s[/color] : %d%%\n"%[GlbDb.resist_eot_dict[k],res_eot[k]]
	return txt

static func resource(dat):
	var txt = ""
	for k in dat.keys():
		if dat[k]>0:
			txt += "[img=16]%s[/img] %d "%[GlbDb.icon_dict[k],dat[k]]
	return txt

static func resource_vert(dat):
	var txt = ""
	for k in dat.keys():
		if dat[k]>0:
			txt += " [img=16]%s[/img] %d\n"%[GlbDb.icon_dict[k],dat[k]]
	return txt

static func build_time(time):
	return "[color=#80ffff]%s[/color] %d Hour"%[GlbDb.FontIcon("time"),time]

static func line(length=24):
	return "[center][s]%s[/s][/center]"%' '.repeat(length)

static func bar_full(rate,max_val=32):
	var v = ceil(max_val*rate)
	var txt = "[font=res://font/mini_pixel.tres]%s[color=#808080]%s[/color][/font]"%['|'.repeat(v),'|'.repeat(max_val-v)]
	return txt

static func site(dat):
	return """
[center][font=res://font/optimus_font.tres]%s[/font][/center]
	%s
	[font=res://font/led_font.tres]%s[/font]
	[color=#%s]%s[/color]
"""%[
	dat.site_name,
	line(24),
	dat.type,
	GlbDb.faction_color[dat.team].to_html(),GlbDb.faction_name[dat.team]
]

static func fleets(rtl:RichTextLabel,fleets):
	rtl.newline()
	for fleet in fleets:
		rtl.append_bbcode(line(20))
		rtl.push_align(RichTextLabel.ALIGN_CENTER)
		
		rtl.append_bbcode("[font=res://font/mini_pixel.tres]%s[/font]"%[fleet.name])
		rtl.pop()
		rtl.append_bbcode(line(20))
		rtl.newline()
		
		for ship in fleet.ships:
			rtl.add_text("    ")
			if ship.has("ofc"):
				rtl.add_image(load(ship.ofc.icon),16,16)
			rtl.add_text("  " + ship.name + "\n\t\t")
			rtl.push_meta(ship)
			rtl.add_image(load(ship.img),64)
			rtl.pop()
			rtl.newline()
	
static func ship(dat):
	return """
	[center][font=res://font/optimus_font.tres]%s[/font]\n[color=#80ffff][s]                        [/s][/color]
	[img]%s[/img][/center]
	[color=#80ffff]Race:[/color] %s
	
	HP: %s [color=#00ff00]%d/%d[/color]
	[color=white]
	\u2629ACC:[color=yellow]%3d%%[/color]	\u219dEVD:[color=yellow]%3d%%[/color]
	\u2736CRT:[color=yellow]%3d%%[/color]	\u2708SPD:[color=yellow]%3d[/color]
	[/color]
	
	%s
	%s
"""%[
	dat.get("name","none"),
	dat.img,
	dat.info.race,
	GlbDat.GetProgressCode(dat.hp,10),
	dat.hp*dat.status.hull,
	dat.status.hull,
	dat.status.acc,
	dat.status.evd,
	dat.status.crt,
	dat.status.spd,
	resist(dat),
	resist_eot(dat),
	]
