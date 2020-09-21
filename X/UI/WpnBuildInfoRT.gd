extends RichTextLabel

func _ready():
	Init()

func Init():
	bbcode_enabled = true
	
func Set(dat):
	var txt = """
[center][b]%s[/b]
[s]                [/s][/center]
	[img=32]%s[/img] %s
	
%s
%s
Cost: %s
%s

"""%[
		dat.get("name","none"),
		dat.get("icon",""),
		sel_txt(dat),
		wu_cd_ammo_txt(dat),
		efx_txt(dat),
		BBCode.resource(dat.get("cost",{})),
		BBCode.build_time(dat.get("time",0))
	]
	bbcode_text = txt

func wu_cd_ammo_txt(dat):
	var txt = ""
	if dat.has("wu"):
		txt += "[color=#804000]Warmup:[/color][color=#ff8000]%d[/color]  "%dat.wu
	if dat.has("cd"):
		txt += "[color=#408080]Cooldown:[/color][color=#80ffff]%d[/color]  "%dat.cd
	if dat.has("ammo"):
		txt += "[color=#808000]Ammo:[/color][color=yellow]%d[/color]"%dat.ammo
	if dat.has("ammo_cap"):
		txt += "[color=yellow]/%d  [/color]"%dat.ammo_cap
	return txt

func sel_txt(dat):
	var txt = "[color=gray]"
	if "select"=="multi":
		txt += "All "
	if dat.affix.has("enm"):
		txt += "Enemy"
	if dat.affix.has("aly"):
		txt += "Ally"
	return txt+"[/color]"

func efx_txt(dat):
	var txt = ""
	for efx in dat.get("efx",[]):
		match efx.type:
			"dmg":
				var dmg_type = efx.get("dmg_type","phy")
				var rnd = efx.get("rnd",0)
				match dmg_type:
					"phy":txt += "[color=#ff8000]Physical "
					"ene":txt += "[color=#00ffff]Energy "
				txt += "Damage: [%d ~ %d][/color]\n"%[floor(efx.dmg*(100-rnd)/100),floor(efx.dmg*(100+rnd)/100)]
				if efx.has("acc"):
					txt += "[color=green]Hit Mod +%d%%[/color]  "%(100+efx.acc)
				if efx.has("crt"):
					txt += "[color=red]Crit Mod +%d%%[/color]"%efx.crt
				txt +="\n"
	return txt
