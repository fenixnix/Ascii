extends RichTextLabel

func Set(dat):
	bbcode_enabled = true
	bbcode_text = DescRT(dat)

static func DescRT(data):
	var txt = """
[center][font=res://font/led_font.tres]%s[/font]
[s]%s[/s][/center]
	"""%[
		data.name,
		" ".repeat(32)
	]
	txt += "\n\n"
	if data.has("type"):
		match data.type:
			"power":
				txt += "[img=16]%s[/img] %d\n"%[GlbDb.icon_dict["power"],data.power_gen]
			"produce":
				txt += "Production:\n"
				for p in data.produce.keys():
					txt += "[img=16]%s[/img] %d/Day\n"%[GlbDb.icon_dict[p],data.produce[p]]
	txt += "\n\n%s"%data.get("desc","no desc")
	
	return txt
